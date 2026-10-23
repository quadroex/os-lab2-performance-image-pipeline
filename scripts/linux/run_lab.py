#!/usr/bin/env python3
"""Reproducible Linux lab collection; standard library only, no privilege changes."""
from __future__ import annotations

import argparse
import csv
import functools
import hashlib
import json
import os
import platform
import shlex
import shutil
import statistics
import subprocess
import sys
import time
from pathlib import Path

import rapl

ROOT = Path(__file__).resolve().parents[2]
VARIANTS = ('image_o0', 'image_scalar', 'image_o3')
ENV = dict(os.environ, LC_ALL='C', LANG='C')
FG_REV = '41fee1f99f9276008b7cd112fca19dc3ea84ac32'


@functools.lru_cache(maxsize=1)
def find_perf():
    explicit = os.environ.get('PERF')
    if explicit:
        return explicit
    candidates = [shutil.which('perf')]
    candidates.extend(str(p) for p in sorted(Path('/usr/lib/linux-tools').glob('*/perf'), reverse=True))
    for candidate in candidates:
        if not candidate:
            continue
        try:
            test = subprocess.run([candidate, '--version'], capture_output=True, timeout=5, env=ENV)
            if test.returncode == 0:
                return candidate
        except (OSError, subprocess.TimeoutExpired):
            pass
    return None


def write_json(path, data):
    Path(path).write_text(json.dumps(data, indent=2, ensure_ascii=False) + '\n', encoding='utf-8')


def read_text(path):
    try:
        return Path(path).read_text().strip()
    except OSError as exc:
        return {'error': str(exc)}


def execute(command, prefix, timeout=600):
    """Save exact argv, UTC interval, stdout/stderr, and status for every attempt."""
    prefix = Path(prefix)
    prefix.parent.mkdir(parents=True, exist_ok=True)
    begin = time.time()
    status = {'argv': list(map(str, command)), 'shell_display': shlex.join(map(str, command)),
              'start_epoch_seconds': begin}
    with prefix.with_suffix('.stdout.txt').open('w', encoding='utf-8') as out, \
         prefix.with_suffix('.stderr.txt').open('w', encoding='utf-8') as err:
        try:
            result = subprocess.run(command, cwd=ROOT, env=ENV, stdout=out, stderr=err, timeout=timeout)
            status.update(returncode=result.returncode, status='ok' if result.returncode == 0 else 'failed')
        except (OSError, subprocess.TimeoutExpired) as exc:
            status.update(returncode=None, status='failed', error=str(exc))
    status['end_epoch_seconds'] = time.time()
    status['wrapper_elapsed_seconds'] = status['end_epoch_seconds'] - begin
    write_json(prefix.with_suffix('.status.json'), status)
    return status


def skipped(prefix, reason):
    status = {'status': 'unavailable', 'reason': reason}
    Path(prefix).parent.mkdir(parents=True, exist_ok=True)
    write_json(Path(prefix).with_suffix('.status.json'), status)
    return status


def inspect(out):
    out.mkdir(parents=True, exist_ok=True)
    data = {'platform': platform.platform(), 'kernel': platform.release(),
            'python': sys.version, 'epoch_seconds': time.time(),
            'affinity_cpus': sorted(os.sched_getaffinity(0)) if hasattr(os, 'sched_getaffinity') else [],
            'is_wsl': 'microsoft' in platform.release().lower(),
            'perf_event_paranoid': read_text('/proc/sys/kernel/perf_event_paranoid'),
            'perf_event_max_sample_rate': read_text('/proc/sys/kernel/perf_event_max_sample_rate'),
            'tools': {name: shutil.which(name) for name in ('g++', 'make', 'perf', 'taskset', 'perl', 'git')},
            'gnu_time_exists': Path('/usr/bin/time').is_file(),
            'powercap_zones': rapl.discover(),
            'policy': 'No sudo, package installation, sysctl, governor, affinity of other processes, or security changes.'}
    data['tools']['perf'] = find_perf()
    perf = find_perf() or 'perf'
    commands = {'uname': ['uname', '-a'], 'lscpu': ['lscpu'], 'cpuinfo': ['cat', '/proc/cpuinfo'],
                'memory': ['cat', '/proc/meminfo'], 'compiler': ['g++', '--version'],
                'perf_version': [perf, '--version'], 'time_version': ['/usr/bin/time', '--version'],
                'power_supply': ['sh', '-c', 'for f in /sys/class/power_supply/*/type /sys/class/power_supply/*/status; do [ ! -r "$f" ] || { echo "$f"; cat "$f"; }; done']}
    for name, command in commands.items():
        data[name] = execute(command, out / name, timeout=20)
    if find_perf():
        # Tiny real probes; a listed event alone does not prove the PMU is accessible.
        data['perf_hardware_probe'] = execute([perf, 'stat', '-e', 'cycles:u,instructions:u', '--', 'sleep', '0.1'], out / 'probe_hardware', 20)
        data['perf_software_probe'] = execute([perf, 'stat', '-e', 'task-clock:u', '--', 'sleep', '0.1'], out / 'probe_software', 20)
    write_json(out / 'capabilities.json', data)
    return data


def benchmark_json(prefix):
    try:
        return json.loads(Path(prefix).with_suffix('.stdout.txt').read_text())
    except (OSError, ValueError):
        return None


def bench_command(args, variant, repeats=None):
    command = [str(ROOT / 'build' / variant), '--width', str(args.width), '--height', str(args.height),
               '--repeats', str(args.repeats if repeats is None else repeats), '--seed', str(args.seed)]
    if args.cpu is not None:
        command = ['taskset', '-c', str(args.cpu)] + command
    return command


def alternating(variants, rounds):
    for run in range(rounds):
        order = list(variants) if run % 2 == 0 else list(reversed(variants))
        for variant in order:
            yield run + 1, variant


def summary_time(records, output):
    summaries = {}
    for variant in VARIANTS:
        rows = [r for r in records if r['variant'] == variant and r['status'] == 'ok']
        values = [r['program']['compute_seconds'] for r in rows if r.get('program')]
        if values:
            summaries[variant] = {'successful_runs': len(values), 'compute_seconds_median': statistics.median(values),
                                  'compute_seconds_min': min(values), 'compute_seconds_max': max(values),
                                  'compute_seconds_sample_stddev': statistics.stdev(values) if len(values) > 1 else None}
    baseline = summaries.get('image_o0', {}).get('compute_seconds_median')
    for values in summaries.values():
        values['speedup_vs_o0'] = baseline / values['compute_seconds_median'] if baseline else None
    write_json(output, {'metric': 'program compute_seconds, excludes input generation and final checksum',
                        'variants': summaries, 'raw_runs': records,
                        'note': 'GNU time reports full process lifetime separately; do not substitute one metric for the other.'})


def collect(args):
    if platform.system() != 'Linux':
        raise SystemExit('This collector requires Linux. It does not emulate perf or energy counters on Windows.')
    output = Path(args.output).resolve() if args.output else ROOT / 'results' / ('linux-' + time.strftime('%Y%m%dT%H%M%SZ', time.gmtime()))
    output.mkdir(parents=True, exist_ok=False)
    print('Reading environment:', output, flush=True)
    capabilities = inspect(output / 'environment')
    allowed = capabilities['affinity_cpus']
    if args.cpu is None and allowed and shutil.which('taskset'):
        args.cpu = allowed[0]
    if args.cpu is not None and (args.cpu not in allowed or not shutil.which('taskset')):
        raise SystemExit('Requested CPU is not in this process affinity or taskset is missing.')
    for variant in args.variants:
        if not os.access(ROOT / 'build' / variant, os.X_OK):
            raise SystemExit('Missing executable: build/' + variant + '; run make first.')
    hashes = {variant: hashlib.sha256((ROOT / 'build' / variant).read_bytes()).hexdigest() for variant in args.variants}
    write_json(output / 'manifest.json', {'arguments': vars(args), 'binary_sha256': hashes,
                 'workload': {'width': args.width, 'height': args.height, 'repeats': args.repeats, 'seed': args.seed},
                 'run_order': list(alternating(args.variants, args.runs)),
                 'affinity_cpu': args.cpu, 'constant_work': True,
                 'notes': ['Time, perf, sampling, and energy runs are separate instrumentation passes.',
                           'No governor/turbo/background-load settings were changed. Record environmental changes manually.']})
    # Warm up every variant using the exact workload once and establish bit-exact correctness.
    checksums = {}
    for variant in args.variants:
        print('Warmup/correctness:', variant, flush=True)
        prefix = output / 'warmup' / variant
        status = execute(bench_command(args, variant), prefix, args.timeout)
        program = benchmark_json(prefix)
        if status['status'] != 'ok' or not program or 'checksum' not in program:
            raise SystemExit('Warmup/correctness failed: ' + str(prefix))
        checksums[variant] = program['checksum']
    write_json(output / 'checksums.json', checksums)
    if len(set(checksums.values())) != 1:
        raise SystemExit('Checksums differ; comparisons stopped.')
    records = []
    for run, variant in alternating(args.variants, args.runs):
        print(f'GNU time: run {run}/{args.runs} {variant}', flush=True)
        prefix = output / 'time' / f'{run:02d}-{variant}'
        command = bench_command(args, variant)
        if Path('/usr/bin/time').is_file():
            status = execute(['/usr/bin/time', '--verbose', '--output', str(prefix.with_suffix('.time.txt'))] + command, prefix, args.timeout)
        else:
            status = skipped(prefix, '/usr/bin/time missing')
        program = benchmark_json(prefix)
        if status['status'] == 'ok' and not program:
            status['status'] = 'failed'
            status['reason'] = 'benchmark did not emit expected JSON'
            write_json(prefix.with_suffix('.status.json'), status)
        if program and program.get('checksum') != next(iter(checksums.values())):
            raise SystemExit('Checksum mismatch in timed run: ' + str(prefix))
        records.append({'run': run, 'variant': variant, 'status': status['status'], 'program': program})
    summary_time(records, output / 'timing-summary.json')
    if not args.skip_perf:
        collect_perf(args, output)
    if not args.skip_energy:
        collect_energy(args, output, next(iter(checksums.values())))
    print(output)
    print('Collection ended. Inspect status files: successful timing does not imply perf or energy availability.')


def collect_perf(args, output):
    perf = find_perf()
    if perf:
        ENV['PERF'] = perf
    for run, variant in alternating(args.variants, args.runs):
        print(f'perf stat: run {run}/{args.runs} {variant}', flush=True)
        prefix = output / 'perf-stat' / f'{run:02d}-{variant}'
        prefix.parent.mkdir(parents=True, exist_ok=True)
        if not perf:
            skipped(prefix, 'perf executable missing')
            continue
        status = execute([perf, 'stat', '-d', '--no-big-num', '-o', str(prefix.with_suffix('.perf.txt')), '--'] + bench_command(args, variant), prefix, args.timeout)
        raw = read_text(prefix.with_suffix('.perf.txt'))
        if status['status'] == 'ok' and isinstance(raw, str) and ('<not supported>' in raw or '<not counted>' in raw):
            status['status'] = 'partial'
            status['reason'] = 'Some hardware counters were not supported or not counted; retain raw output and do not invent values.'
            write_json(prefix.with_suffix('.status.json'), status)
    # Profile each variant separately, fixed useful work and identical event/frequency.
    for variant in args.variants:
        print('perf record/report/FlameGraph:', variant, flush=True)
        base = output / 'profiles' / variant
        base.mkdir(parents=True, exist_ok=True)
        prefix = base / 'record'
        if not perf:
            skipped(prefix, 'perf executable missing')
            continue
        data = base / 'perf.data'
        command = [perf, 'record', '-e', args.profile_event, '-F', str(args.frequency), '--call-graph', 'dwarf,16384', '-o', str(data), '--'] + bench_command(args, variant, args.profile_repeats or args.repeats)
        status = execute(command, prefix, args.timeout)
        if status['status'] != 'ok' or not data.exists() or data.stat().st_size == 0:
            skipped(base / 'report', 'perf record failed or produced no data; inspect record.stderr.txt')
            continue
        execute([perf, 'report', '--stdio', '--show-nr-samples', '--no-children', '-i', str(data)], base / 'report', args.timeout)
        execute([perf, 'report', '--stdio', '--show-nr-samples', '-i', str(data)], base / 'report-inclusive', args.timeout)
        script = execute([perf, 'script', '-i', str(data)], base / 'stacks', args.timeout)
        if script['status'] != 'ok':
            skipped(base / 'flamegraph', 'perf script failed')
            continue
        fg = Path(args.flamegraph_dir).resolve() if args.flamegraph_dir else ROOT / 'tools' / 'FlameGraph'
        if not (fg / 'stackcollapse-perf.pl').is_file() or not (fg / 'flamegraph.pl').is_file():
            skipped(base / 'flamegraph', 'FlameGraph source absent. Run bash scripts/linux/fetch_flamegraph.sh, then render_flamegraph.sh on this profile directory.')
            continue
        execute(['bash', str(ROOT / 'scripts/linux/render_flamegraph.sh'), str(base), str(fg)], base / 'flamegraph', args.timeout)


def collect_energy(args, output, expected_checksum):
    zones, reason = rapl.choose_packages(rapl.discover())
    energy = {'status': 'ok' if zones else 'unavailable', 'domains': zones, 'runs': [],
              'scope': 'CPU package energy only; whole-system AC/DC input energy remains a separate measurement.',
              'whole_system_status': 'not_measured; use a real external meter and import_wattmeter.py',
              'method': 'Each workload window bracketed by two idle reference windows; arithmetic mean idle power is subtracted.',
              'estimate': 'Incremental package energy attributed to workload under idle-baseline assumption; not direct per-PID measurement.',
              'reason': reason if reason else (None if zones else 'No readable package domains. No sudo or permission changes attempted.')}
    write_json(output / 'energy-summary.json', energy)
    if not zones:
        print('Linux RAPL package energy unavailable; saved explicit status.', flush=True)
        return
    for run, variant in alternating(args.variants, args.energy_runs):
        print(f'RAPL: run {run}/{args.energy_runs} {variant}', flush=True)
        base = output / 'energy' / f'{run:02d}-{variant}'
        before = rapl.capture(zones, base / 'idle-before', duration=args.idle_seconds)
        active = rapl.capture(zones, base / 'active', command=bench_command(args, variant), timeout=args.timeout)
        after = rapl.capture(zones, base / 'idle-after', duration=args.idle_seconds)
        row = {'run': run, 'variant': variant, 'idle_before': before, 'active': active, 'idle_after': after}
        if all(window['status'] == 'ok' for window in (before, active, after)):
            idle_power = (before['mean_power_w'] + after['mean_power_w']) / 2
            estimate = active['energy_j'] - idle_power * active['window_seconds']
            row.update(status='ok', reference_idle_power_w=idle_power,
                       incremental_package_energy_estimate_j=estimate,
                       estimate_quality='negative estimate: baseline/noise invalidates positive attribution' if estimate < 0 else 'approximate; background activity and frequency/thermal changes confound attribution')
            program = benchmark_json(base / 'active')
            if not program or program.get('checksum') != expected_checksum:
                row['status'] = 'failed'
                row['reason'] = 'benchmark output missing or checksum differs'
        else:
            row['status'] = 'failed'
        energy['runs'].append(row)
        write_json(base / 'summary.json', row)
        write_json(output / 'energy-summary.json', energy)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    sub = parser.add_subparsers(dest='mode', required=True)
    check = sub.add_parser('check', help='Read environment and run tiny counter probes without changing permissions.')
    check.add_argument('--output', default=str(ROOT / 'results' / 'linux-capabilities'))
    run = sub.add_parser('collect', help='Run actual benchmark passes; no fabricated results on unsupported hosts.')
    run.add_argument('--output')
    run.add_argument('--width', type=int, default=2048)
    run.add_argument('--height', type=int, default=2048)
    run.add_argument('--repeats', type=int, default=20)
    run.add_argument('--seed', type=int, default=12345)
    run.add_argument('--runs', type=int, default=5)
    run.add_argument('--variants', nargs='+', choices=VARIANTS, default=list(VARIANTS))
    run.add_argument('--cpu', type=int, help='CPU from allowed affinity; defaults to first allowed CPU when taskset exists.')
    run.add_argument('--timeout', type=float, default=600)
    run.add_argument('--profile-event', default='cpu-clock:u', help='Default is a software CPU-time event; cycles:u requires working hardware PMU.')
    run.add_argument('--frequency', type=int, default=199)
    run.add_argument('--profile-repeats', type=int, help='Use the same larger repeat count for ALL profiles if optimized run is too short.')
    run.add_argument('--flamegraph-dir')
    run.add_argument('--energy-runs', type=int, default=3)
    run.add_argument('--idle-seconds', type=float, default=3)
    run.add_argument('--skip-perf', action='store_true')
    run.add_argument('--skip-energy', action='store_true')
    args = parser.parse_args()
    if args.mode == 'check':
        inspect(Path(args.output).resolve())
        print(Path(args.output).resolve())
    else:
        for name in ('width', 'height', 'repeats', 'runs', 'frequency', 'energy_runs', 'idle_seconds', 'timeout'):
            if getattr(args, name) <= 0:
                parser.error('--' + name.replace('_', '-') + ' must be positive')
        if args.profile_repeats is not None and args.profile_repeats <= 0:
            parser.error('--profile-repeats must be positive')
        collect(args)


if __name__ == '__main__':
    main()
