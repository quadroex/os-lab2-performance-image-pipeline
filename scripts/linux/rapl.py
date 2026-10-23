"""Read Linux powercap energy counters. Never writes sysfs or changes access rights."""
from __future__ import annotations

import csv
import os
import subprocess
import time
from pathlib import Path


def discover():
    """Return unique zones, including unreadable ones for honest capability reporting."""
    zones, seen = [], set()
    for root in (Path('/sys/devices/virtual/powercap'), Path('/sys/class/powercap')):
        if not root.exists():
            continue
        for directory, children, files in os.walk(root, followlinks=True):
            resolved = str(Path(directory).resolve())
            if resolved in seen:
                children[:] = []
                continue
            seen.add(resolved)
            # Only follow actual powercap zone directories; do not enter device/subsystem links.
            children[:] = [c for c in children if c not in ('device', 'subsystem', 'power')]
            if 'energy_uj' not in files:
                continue
            path = Path(directory).resolve()
            zone = {'path': str(path), 'id': path.name, 'readable': False}
            try:
                zone.update(name=(path / 'name').read_text().strip(),
                            max_energy_range_uj=int((path / 'max_energy_range_uj').read_text()),
                            initial_energy_uj=int((path / 'energy_uj').read_text()))
                if zone['max_energy_range_uj'] <= 0:
                    raise ValueError('nonpositive max_energy_range_uj')
                zone['readable'] = True
            except (OSError, ValueError) as exc:
                zone['error'] = str(exc)
            zones.append(zone)
    return sorted(zones, key=lambda zone: zone['path'])


def choose_packages(zones):
    """Default: CPU package zones only. Never sum package + core/uncore/psys."""
    chosen = [z for z in zones if z.get('readable') and z.get('name', '').startswith('package-')]
    # Reject duplicate drivers exposing the same package instead of double counting it.
    by_name = {}
    for zone in chosen:
        by_name.setdefault(zone['name'], []).append(zone)
    if any(len(values) != 1 for values in by_name.values()):
        return [], 'ambiguous duplicate package domains; select one driver manually'
    return validate_disjoint(chosen), None


def validate_disjoint(zones):
    for index, left in enumerate(zones):
        for right in zones[index + 1:]:
            a, b = Path(left['path']), Path(right['path'])
            if a == b or a in b.parents or b in a.parents:
                raise ValueError('overlapping RAPL hierarchy: ' + str(a) + ' and ' + str(b))
    return zones


def capture(zones, prefix, command=None, duration=None, interval=0.1, timeout=600):
    """Poll frequently to account for counter wraps; save every raw reading.

    At most one wrap is assumed per poll interval. This is an explicit measurement
    assumption, not a claim that this interface can detect arbitrary resets/wraps.
    With command=None capture an idle reference window of the requested duration.
    """
    prefix = Path(prefix)
    prefix.parent.mkdir(parents=True, exist_ok=True)
    if not zones:
        return {'status': 'unavailable', 'reason': 'no selected readable package-energy zones'}
    start_epoch = time.time()
    start = time.monotonic()
    previous, totals = {}, {z['path']: 0 for z in zones}
    samples, wraps = 0, {z['path']: 0 for z in zones}
    max_gap, last_sample, errors = 0.0, None, []
    proc = None
    out = prefix.with_suffix('.stdout.txt').open('w', encoding='utf-8')
    err = prefix.with_suffix('.stderr.txt').open('w', encoding='utf-8')
    try:
        with prefix.with_suffix('.samples.csv').open('w', newline='', encoding='utf-8') as handle:
            writer = csv.writer(handle)
            writer.writerow(['monotonic_seconds', 'epoch_seconds', 'zone_path', 'zone_name', 'energy_uj'])

            def sample():
                nonlocal samples, last_sample, max_gap
                now = time.monotonic()
                if last_sample is not None:
                    max_gap = max(max_gap, now - last_sample)
                last_sample = now
                for zone in zones:
                    key = zone['path']
                    value = int((Path(key) / 'energy_uj').read_text())
                    writer.writerow([f'{now:.9f}', f'{time.time():.9f}', key, zone['name'], value])
                    if key in previous:
                        delta = value - previous[key]
                        if delta < 0:
                            delta += zone['max_energy_range_uj']
                            wraps[key] += 1
                        if delta < 0:
                            raise ValueError('counter changed outside advertised range: ' + key)
                        totals[key] += delta
                    previous[key] = value
                samples += 1
                handle.flush()

            sample()
            start = last_sample
            start_epoch = time.time()
            if command is not None:
                proc = subprocess.Popen(command, stdout=out, stderr=err,
                                        env=dict(os.environ, LC_ALL='C', LANG='C'))
            while True:
                if proc is not None and proc.poll() is not None:
                    break
                if proc is None and time.monotonic() - start >= duration:
                    break
                if proc is not None:
                    if time.monotonic() - start >= timeout:
                        proc.kill()
                        errors.append('benchmark exceeded energy timeout and was killed')
                        break
                    try:
                        proc.wait(timeout=interval)
                        break
                    except subprocess.TimeoutExpired:
                        sample()
                else:
                    time.sleep(interval)
                    sample()
            sample()
            returncode = proc.wait() if proc is not None else 0
    except (OSError, ValueError) as exc:
        errors.append(str(exc))
        # Preserve the benchmark's normal completion even if energy access disappears.
        returncode = proc.wait() if proc is not None else None
    finally:
        out.close()
        err.close()
    elapsed = last_sample - start if last_sample is not None else 0
    domains = [{'name': z['name'], 'path': z['path'],
                'energy_j': totals[z['path']] / 1_000_000,
                'wraps_observed': wraps[z['path']],
                'max_energy_range_uj': z['max_energy_range_uj']} for z in zones]
    total = sum(z['energy_j'] for z in domains)
    return {'status': 'ok' if not errors and returncode == 0 else 'failed',
            'scope': 'sum of disjoint CPU package domains; not whole-computer or per-PID energy',
            'start_epoch_seconds': start_epoch, 'end_epoch_seconds': time.time(),
            'window_seconds': elapsed, 'energy_j': total,
            'mean_power_w': total / elapsed if elapsed else None,
            'poll_interval_seconds': interval, 'maximum_poll_gap_seconds': max_gap,
            'samples': samples, 'returncode': returncode, 'errors': errors, 'domains': domains,
            'assumptions': ['At most one counter wrap between successive samples.',
                            'No counter reset, hotplug, suspend, or powercap driver change during capture.',
                            'Sampling includes launch/exit and polling overhead; same sampler used for idle.']}
