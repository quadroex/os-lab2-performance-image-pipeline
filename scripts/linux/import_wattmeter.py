#!/usr/bin/env python3
"""Integrate a REAL external power-meter CSV; never synthesizes missing measurements.

CSV columns: timestamp,power_w. timestamp is Unix epoch seconds or ISO-8601 with
an explicit offset/Z. The trace must cover both boundaries of each requested window.
"""
from __future__ import annotations

import argparse
import csv
import datetime as dt
import json
import math
from pathlib import Path


def timestamp(value):
    try:
        return float(value)
    except ValueError:
        parsed = dt.datetime.fromisoformat(value.replace('Z', '+00:00'))
        if parsed.tzinfo is None:
            raise ValueError('ISO timestamp requires an explicit timezone: ' + value)
        return parsed.timestamp()


def integrate(points, start, end, max_gap):
    if not all(math.isfinite(v) for v in (start, end, max_gap)):
        raise ValueError('window boundaries and max gap must be finite')
    if end <= start:
        raise ValueError('window end must follow its start')
    if not points or points[0][0] > start or points[-1][0] < end:
        raise ValueError('meter trace does not cover requested boundaries; no extrapolation is allowed')
    energy, gaps = 0.0, []
    for (ta, pa), (tb, pb) in zip(points, points[1:]):
        a, b = max(ta, start), min(tb, end)
        if a >= b:
            continue
        if tb - ta > max_gap:
            raise ValueError(f'meter gap {tb - ta:g}s exceeds --max-gap {max_gap:g}s')
        at_a = pa + (pb - pa) * (a - ta) / (tb - ta)
        at_b = pa + (pb - pa) * (b - ta) / (tb - ta)
        energy += (at_a + at_b) * 0.5 * (b - a)
        gaps.append(tb - ta)
    return {'start_epoch_seconds': start, 'end_epoch_seconds': end,
            'duration_seconds': end - start, 'energy_j': energy,
            'average_power_w': energy / (end - start), 'max_sample_gap_seconds': max(gaps)}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('csv', type=Path)
    parser.add_argument('--start', help='Active interval start: epoch seconds or timezone-aware ISO8601')
    parser.add_argument('--end')
    parser.add_argument('--status-file', type=Path, help='Use start/end from a successful *.status.json instead of --start/--end')
    parser.add_argument('--idle-start', required=True)
    parser.add_argument('--idle-end', required=True)
    parser.add_argument('--max-gap', type=float, default=2.0)
    parser.add_argument('--meter', required=True, help='Actual model and logging method, including stated accuracy')
    parser.add_argument('--scope', required=True, help='E.g. AC wall input to entire desktop, excluding monitor')
    parser.add_argument('--label', required=True, help='Variant and run identifier')
    parser.add_argument('--output', required=True, type=Path)
    args = parser.parse_args()
    try:
        with args.csv.open(newline='', encoding='utf-8-sig') as handle:
            points = [(timestamp(row['timestamp']), float(row['power_w'])) for row in csv.DictReader(handle)]
        if len(points) < 2 or any(b[0] <= a[0] for a, b in zip(points, points[1:])):
            raise ValueError('need at least two samples with strictly increasing timestamps')
        if not all(math.isfinite(t) and math.isfinite(p) for t, p in points):
            raise ValueError('all timestamps and powers must be finite')
        if not math.isfinite(args.max_gap) or args.max_gap <= 0:
            raise ValueError('--max-gap must be finite and positive')
        if any(power < 0 for _, power in points):
            raise ValueError('negative power not supported by this consumption-only importer')
        if args.status_file:
            if args.start or args.end:
                raise ValueError('use either --status-file or --start/--end')
            status = json.loads(args.status_file.read_text(encoding='utf-8'))
            if status.get('status') != 'ok':
                raise ValueError('status file is not a successful workload run')
            start, end = status['start_epoch_seconds'], status['end_epoch_seconds']
        else:
            if not args.start or not args.end:
                raise ValueError('--start and --end are required without --status-file')
            start, end = timestamp(args.start), timestamp(args.end)
        active = integrate(points, start, end, args.max_gap)
        idle = integrate(points, timestamp(args.idle_start), timestamp(args.idle_end), args.max_gap)
        if max(start, idle['start_epoch_seconds']) < min(end, idle['end_epoch_seconds']):
            raise ValueError('idle reference overlaps the active window')
        estimate = active['energy_j'] - idle['average_power_w'] * active['duration_seconds']
        result = {'status': 'ok', 'label': args.label, 'source_csv': str(args.csv.resolve()),
                  'meter': args.meter, 'scope': args.scope,
                  'integration': 'trapezoidal, linear interpolation only inside the sampled trace',
                  'active_system_measurement': active, 'idle_reference': idle,
                  'application_incremental_energy_estimate_j': estimate,
                  'attribution': 'Approximate active-minus-idle whole-system energy, not direct per-PID measurement.',
                  'limitations': ['Other activity, thermal/frequency drift, and meter uncertainty affect attribution.',
                                 'Laptop charger input can include battery charging; document battery state.',
                                 'Clock synchronization and sampling rate limit interval accuracy.',
                                 'Negative estimates are retained and indicate baseline/noise problems.']}
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(json.dumps(result, indent=2, ensure_ascii=False) + '\n', encoding='utf-8')
    except (OSError, ValueError, KeyError) as exc:
        parser.error(str(exc))
    print(args.output)


if __name__ == '__main__':
    main()
