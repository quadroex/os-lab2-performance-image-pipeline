#!/usr/bin/env python3
"""Derive summaries only from actual saved runs; never substitute missing values."""
from __future__ import annotations
import argparse
import csv
import json
import re
import statistics as stats
from pathlib import Path

VARIANTS = ('image_o0', 'image_scalar', 'image_o3')
LABELS = ('O0', 'O3 scalar', 'O3')

WORKLOAD_KEYS = ('width', 'height', 'repeats', 'seed')

def display_path(path, root):
    try:
        return str(path.relative_to(root))
    except ValueError:
        return str(path)

def usable_raw_files(folder, variant, suffix):
    """Failed attempts remain raw evidence, but do not become successful observations."""
    accepted = []
    for path in sorted(folder.glob('*-' + variant + suffix)):
        status_path = path.with_name(path.name.removesuffix(suffix) + '.status.json')
        if status_path.exists():
            state = json.loads(status_path.read_text(encoding='utf-8-sig')).get('status')
            if state not in ('ok', 'partial'):
                continue
        accepted.append(path)
    return accepted

def clock_seconds(text):
    result = 0.0
    for part in text.strip().split(':'):
        result = result * 60 + float(part)
    return result

def parse_time(path):
    data = {}
    for line in path.read_text().splitlines():
        line = line.strip()
        if line.startswith('Elapsed (wall clock)'):
            data['wall_seconds'] = clock_seconds(line.rsplit(': ', 1)[1])
        for raw, key in (('User time (seconds)', 'user_seconds'),
                         ('System time (seconds)', 'system_seconds'),
                         ('Maximum resident set size (kbytes)', 'max_rss_kib'),
                         ('Minor (reclaiming a frame) page faults', 'minor_faults'),
                         ('Major (requiring I/O) page faults', 'major_faults'),
                         ('Voluntary context switches', 'voluntary_switches'),
                         ('Involuntary context switches', 'involuntary_switches')):
            if line.startswith(raw + ':'):
                data[key] = float(line.rsplit(':', 1)[1])
    return data

def parse_perf(path):
    events = {}
    for line in path.read_text().splitlines():
        found = re.match(r'^\s*([0-9.]+|<not supported>|<not counted>)\s+(?:(msec)\s+)?([A-Za-z0-9_.:-]+)', line)
        if not found:
            continue
        count, unit, event = found.groups()
        if event in ('seconds', 'CPUs', 'of'):
            continue
        value = None if count.startswith('<') else float(count)
        events[event] = value
    if events.get('cycles') and events.get('instructions'):
        events['ipc'] = events['instructions'] / events['cycles']
    for event, total, key in (('branch-misses', 'branches', 'branch_miss_fraction'),
                              ('L1-dcache-load-misses', 'L1-dcache-loads', 'l1_load_miss_fraction')):
        if events.get(total) and events.get(event) is not None:
            events[key] = events[event] / events[total]
    return events

def describe(rows):
    keys = set().union(*(row.keys() for row in rows)) if rows else set()
    result = {}
    for key in sorted(keys):
        values = [row[key] for row in rows if isinstance(row.get(key), (int, float))]
        if values:
            result[key] = {'n': len(values), 'median': stats.median(values),
                           'min': min(values), 'max': max(values),
                           'sample_stddev': stats.stdev(values) if len(values) > 1 else None}
        else:
            result[key] = {'n': 0, 'median': None}
    return result

def profile(path):
    leaves = {}; inclusive = {}; total = 0
    if not path.exists():
        return {'status': 'unavailable'}
    invalid_lines = 0
    for line in path.read_text().splitlines():
        if not line.strip():
            continue
        try:
            stack, number = line.rsplit(' ', 1)
            count = int(number)
            if count <= 0:
                raise ValueError('nonpositive sample count')
        except ValueError:
            invalid_lines += 1
            continue
        total += count
        # Preserve raw folded files. Ignore only known display annotations when
        # grouping symbols, e.g. function_[i], function_[k], function_[.].
        names = [re.sub(r'(?:_?\[(?:\.|k|j|i)\])+$', '', name.strip()).strip()
                 for name in stack.split(';')]
        leaves[names[-1]] = leaves.get(names[-1], 0) + count
        for name in set(names):
            inclusive[name] = inclusive.get(name, 0) + count
    keys = ('rgb_to_grayscale', 'adjust_contrast', 'horizontal_blur_5tap')
    if not total:
        return {'status': 'unavailable', 'reason': 'no positive folded event weights',
                'invalid_lines': invalid_lines}
    event = None
    record_status = path.parent / 'record.status.json'
    if record_status.exists():
        argv = json.loads(record_status.read_text()).get('argv', [])
        if '-e' in argv:
            event = argv[argv.index('-e') + 1]
    units = 'nanoseconds' if event and event.split(':')[0] in ('cpu-clock', 'task-clock') else 'event period weight; units unspecified'
    raw_count = None
    raw_count_source = None
    record_log = path.parent / 'record.stderr.txt'
    if record_log.exists():
        match = re.search(r'\(([0-9,]+) samples\)', record_log.read_text())
        if match:
            raw_count = int(match.group(1).replace(',', ''))
            raw_count_source = 'record.stderr.txt: exact perf record count'
    report_total = None
    report_path = path.parent / 'report.stdout.txt'
    if report_path.exists():
        report_text = report_path.read_text()
        # The Samples banner can abbreviate 3163 as 3K; use exact table counts
        # instead of interpreting that banner as an exact integer.
        report_counts = re.findall(r'^\s*\d+(?:\.\d+)?%\s+(\d+)\s+\S+\s+\S+\s+\[[^\]]+\]', report_text, re.M)
        if report_counts:
            report_total = sum(map(int, report_counts))
        if raw_count is None:
            match = re.search(r'^# Samples:\s*(\d+)\s+of event', report_text, re.M)
            if match:
                raw_count = int(match.group(1))
                raw_count_source = 'report.stdout.txt: unabridged Samples banner'
    kernel_weights = {key: inclusive.get(key, 0) for key in keys}
    return {'status': 'ok', 'event': event,
            'folded_weight_total': total, 'folded_weight_units': units,
            'weighting': 'stackcollapse-perf sums period values from this perf script output; folded values are not raw sample counts',
            'raw_sample_count': raw_count, 'raw_sample_count_source': raw_count_source,
            'report_self_sample_count_sum': report_total,
            'invalid_lines': invalid_lines,
            'kernel_inclusive_weight': kernel_weights,
            'kernel_inclusive_fractions': {key: value/total for key,value in kernel_weights.items()},
            'top_leaf_symbols': [{'symbol': key, 'event_period_weight': value, 'fraction': value/total}
                for key, value in sorted(leaves.items(), key=lambda row: row[1], reverse=True)[:15]]}

def main():
    parser = argparse.ArgumentParser(description=__doc__, epilog=(
        'Each statistic uses available valid observations only. n is reported per metric; '
        'min/max and chart error bars describe observed runs, not confidence intervals. '
        'Missing or unsupported counters remain null; failed attempts are excluded. '
        'Energy must use the same width, height, repeats, and seed as the Linux workload.'))
    parser.add_argument('--linux', default='results/linux-main')
    parser.add_argument('--energy', help='Directory from run_sync_energy_series.ps1; legacy launch-inclusive series is diagnostic only')
    parser.add_argument('--output', default='results/analysis')
    parser.add_argument('--no-plots', action='store_true', help='Write summary JSON and CSV without importing plotting libraries.')
    args = parser.parse_args()
    root = Path(__file__).resolve().parents[1]
    linux = root / args.linux; out = root / args.output; out.mkdir(parents=True, exist_ok=True)
    summary = {'source_linux': display_path(linux, root), 'variants': {},
               'interpretation': {
                   'n': 'available valid observations for each individual metric',
                   'range': 'observed minimum/maximum, not a confidence interval',
                   'perf': 'raw event counts; task-clock is milliseconds in these perf stat files',
                   'profile': 'folded event-period weights, not raw sample counts; inclusive kernel memberships may overlap',
                   'energy': 'named hardware domains, not whole-PC or exact per-PID energy'}}
    timing = json.loads((linux / 'timing-summary.json').read_text())
    programs = [row['program'] for row in timing.get('raw_runs', [])
                if row.get('status') == 'ok' and row.get('program')]
    workloads = {tuple(program.get(key) for key in WORKLOAD_KEYS) for program in programs}
    if len(workloads) != 1:
        raise ValueError('Expected one verified workload in successful timing runs.')
    workload = dict(zip(WORKLOAD_KEYS, next(iter(workloads))))
    checksums = {program.get('checksum') for program in programs}
    if len(checksums) != 1 or None in checksums:
        raise ValueError('Successful timing runs must have one nonmissing checksum.')
    summary['workload'] = workload
    summary['checksum'] = next(iter(checksums))
    for variant in VARIANTS:
        summary['variants'][variant] = {
            'compute': timing['variants'].get(variant, {}),
            'time': describe([parse_time(p) for p in usable_raw_files(linux/'time', variant, '.time.txt')]),
            'perf': describe([parse_perf(p) for p in usable_raw_files(linux/'perf-stat', variant, '.perf.txt')]),
            'profile': profile(linux/'profiles'/variant/'stacks.folded')}
    if args.energy:
        energy_dir = root / args.energy
        summary['source_energy'] = display_path(energy_dir, root)
        energy_rows = []
        for path in sorted(energy_dir.glob('*.json')):
            row = json.loads(path.read_text(encoding='utf-8-sig'))
            if row.get('Status') != 'ok' or 'StandardOutput' not in row:
                continue
            program = json.loads(row['StandardOutput'])
            if any(program.get(key) != workload[key] for key in WORKLOAD_KEYS):
                raise ValueError('Energy workload differs from Linux workload: ' + str(path))
            if program.get('checksum') != summary['checksum']:
                raise ValueError('Energy checksum differs from verified Linux result: ' + str(path))
            variant = {'O0':'image_o0','O3':'image_o3','O3-scalar':'image_scalar'}[program['build_variant']]
            measurements = {(x['Device'], x['Channel']): x for x in row['ActiveDomainMeasurements']}
            estimates = {(x['Device'], x['Channel']): x for x in row['IncrementalEstimates']}
            data = {'variant': variant, 'source': display_path(path, root),
                    'host_process_wall_seconds': row['ProcessWallSeconds'],
                    'synchronized_wall_seconds': row.get('SynchronizedWallSeconds'),
                    'linux_child_wall_seconds': row.get('LinuxChildWallSeconds'),
                    'energy_window_scope': row.get('EnergyWindowScope', row.get('ProcessWallScope')),
                    'method': row.get('Method')}
            for suffix, prefix in (('_PKG','package'),('_DRAM','dram')):
                found = [key for key in measurements if key[1].endswith(suffix)]
                # Do not silently overwrite or sum multiple devices/packages.
                if len(found) != 1:
                    continue
                channel = found[0]; item = measurements[channel]; net = estimates.get(channel, {})
                if item['Status'] == 'ok':
                    data[prefix+'_joules'] = item['EnergyJoules']
                    data[prefix+'_watts'] = item['AverageWatts']
                    data[prefix+'_energy_window_seconds'] = item['DurationSeconds']
                    if net.get('Status') in ('estimate', 'negative_estimate_background_or_thermal_variation'):
                        data[prefix+'_incremental_estimate_joules'] = net.get('EstimatedIncrementalEnergyJoules')
            energy_rows.append(data)
        for variant in VARIANTS:
            rows = [{k:v for k,v in row.items() if isinstance(v,(int,float))} for row in energy_rows if row['variant']==variant]
            summary['variants'][variant]['energy'] = describe(rows)
        summary['energy_raw_rows'] = energy_rows
    (out/'summary.json').write_text(json.dumps(summary, indent=2, ensure_ascii=False)+'\n', encoding='utf-8')
    columns = ['variant','compute_s','wall_s','rss_kib','instructions','cycles','ipc','package_j','package_net_estimate_j']
    with (out/'comparison.csv').open('w',newline='',encoding='utf-8') as handle:
        writer=csv.writer(handle);writer.writerow(columns)
        for variant,data in summary['variants'].items():
            med=lambda section,key: data.get(section,{}).get(key,{}).get('median')
            writer.writerow([variant,data['compute'].get('compute_seconds_median'),med('time','wall_seconds'),med('time','max_rss_kib'),med('perf','instructions'),med('perf','cycles'),med('perf','ipc'),med('energy','package_joules'),med('energy','package_incremental_estimate_joules')])
    if args.no_plots:
        print(out/'summary.json')
        return
    try:
        import matplotlib
        matplotlib.use('Agg')
        import matplotlib.pyplot as plt
        plt.rcParams.update({'font.family':'DejaVu Sans','font.size':10,'svg.fonttype':'none'})
        panels=[('Compute time, seconds','compute',None),('Retired instructions, billions','perf','instructions'),('CPU package energy, joules','energy','package_joules'),('Incremental CPU package estimate, joules','energy','package_incremental_estimate_joules')]
        fig,axs=plt.subplots(2,2,figsize=(11,7),layout='constrained')
        colors=['#ad4f44','#778b9f','#247a66']
        for ax,(title,section,key) in zip(axs.flat,panels):
            vals=[]; lower=[]; upper=[]; counts=[]; lows=[]
            for variant in VARIANTS:
                data=summary['variants'][variant]
                if section=='compute':
                    item=data['compute'];v=item.get('compute_seconds_median');lo=item.get('compute_seconds_min');hi=item.get('compute_seconds_max')
                    count=item.get('successful_runs',0)
                else:
                    item=data.get(section,{}).get(key,{});v=item.get('median');lo=item.get('min');hi=item.get('max')
                    count=item.get('n',0)
                scale=1e9 if key=='instructions' else 1
                vals.append(None if v is None else v/scale)
                lows.append(None if lo is None else lo/scale);counts.append(count)
                lower.append(0 if v is None else (v-lo)/scale);upper.append(0 if v is None else (hi-v)/scale)
            ax.set_title(title,loc='left',fontweight='bold');ax.spines[['top','right']].set_visible(False)
            if any(v is None for v in vals):
                ax.text(.5,.5,'Not measured / unavailable',ha='center',va='center',transform=ax.transAxes)
                continue
            labels=[label+'\nn='+str(count) for label,count in zip(LABELS,counts)]
            bars=ax.bar(labels,vals,color=colors,yerr=[lower,upper],capsize=4,width=.6)
            ax.set_ylim(bottom=min(0,min(lows)*1.2));ax.grid(axis='y',alpha=.18);ax.set_axisbelow(True)
            ax.bar_label(bars,fmt='%.2f',padding=5)
            ax.margins(y=.18)
        fig.suptitle(f"Same image pipeline: {workload['width']}×{workload['height']} pixels, {workload['repeats']} repeats\nMedians; error bars show observed min–max, not confidence intervals",fontsize=13)
        fig.savefig(out/'comparison.svg');fig.savefig(out/'comparison.png',dpi=150);plt.close(fig)
    except ImportError:
        pass
    print(out/'summary.json')

if __name__=='__main__':
    main()
