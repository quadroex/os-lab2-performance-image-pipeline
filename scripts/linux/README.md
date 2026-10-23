# Linux collection tools

Run commands from the repository root. Python uses only the standard library.
The scripts never install packages, invoke `sudo`, change `perf_event_paranoid`,
change power limits, disable security, or create measurements for missing sensors.

```bash
# Read environment and test a tiny hardware/software event. Raw errors are saved.
bash scripts/linux/check_environment.sh

# If the distro's /usr/bin/perf wrapper rejects the WSL kernel, select an actual
# installed perf binary. The collector also checks /usr/lib/linux-tools/*/perf.
export PERF=/usr/lib/linux-tools/6.8.0-147-generic/perf

# Required before collection: build the three executables using the Makefile.
# Downloads official public FlameGraph sources at this pinned revision only:
bash scripts/linux/fetch_flamegraph.sh

# Five paired timing/counter runs; three energy pairs when Linux RAPL is readable.
bash scripts/linux/run_all.sh --width 2048 --height 2048 --repeats 20 --runs 5
```

Use a fresh output directory with `--output results/linux-EXPERIMENT`. The default
is a unique UTC timestamp. `--cpu N` selects an allowed logical CPU; otherwise the
first allowed CPU is used if `taskset` exists. On a heterogeneous CPU, record its
core type. CPU pinning does not isolate that CPU from background activity or its
SMT sibling. Power settings, foreground tasks, battery/AC state, and temperature
must be documented alongside each experiment.

Before all runs, every variant executes the exact workload once and its checksum
must match. Repetition order alternates O0/scalar/O3 and O3/scalar/O0 to reduce
order drift. The scalar middle variant is a control for vectorization; O0 and O3
are the main before/after comparison. Fixed image dimensions, seed, and repeat
count mean equal useful work. Warmups are excluded from statistics.

Every attempted command saves its argv, exit status, timestamps, stdout and
stderr. GNU time saves full-process verbose results. `timing-summary.json`
separately summarizes the program's compute timer (which excludes input creation
and the final checksum). Do not mix those two timing definitions.

`perf stat -d` runs in a separate pass so profiler overhead does not contaminate
the reference timing. Unsupported or uncounted events remain in raw files and
are marked partial; an unsupported LLC event is not a zero-cache-miss result.
Check event multiplexing percentages before interpreting counts. IPC is retired
instructions divided by cycles on the same measurement domain. Count reductions
and latency reductions need separate explanations.

## Profiles and FlameGraph

The default event is `cpu-clock:u` at 199 Hz with DWARF call stacks. It samples
user CPU time, not wall-clock delay or off-CPU blocking. This software event can
work when a hardware PMU does not. `--profile-event cycles:u` chooses hardware
cycle sampling only when available. Never compare graphs collected using
different event definitions or frequencies without explaining the difference.

If O3 finishes too fast for enough samples, repeat collection with a larger
`--profile-repeats N`. That repeat count applies equally to all profile variants;
timing remains at `--repeats`. Aim for multiple seconds and inspect the actual
sample counts. A graph with a handful of samples is weak evidence. Profiling
does not turn frequency sampling into exact per-function timings.

The collector retains `perf.data`, `perf report --stdio --show-nr-samples`
(self and inclusive reports), `perf script` output, folded stacks, and an SVG.
Render an existing successful profile again during the defense with:

```bash
bash scripts/linux/render_flamegraph.sh results/linux-EXPERIMENT/profiles/image_o0
bash scripts/linux/render_flamegraph.sh results/linux-EXPERIMENT/profiles/image_o3
```

Show the actual recording command from `record.status.json` and perform a new
`perf record` before rendering when demonstrating the full build process.
`render_flamegraph.sh` uses `$PERF` when explicitly set. FlameGraph uses official
source at commit `41fee1f99f9276008b7cd112fca19dc3ea84ac32`; the fetcher does not run
automatically or modify an existing different checkout.

`stackcollapse-perf.pl` uses the event period printed by `perf script` as the
weight of each sample. In these `cpu-clock:u` profiles, folded totals and SVG
tooltips therefore use **nanoseconds of event-period weight**, not the raw number
of recorded samples. For other events, the renderer uses the generic unit
`event weight`; interpret that using the selected event. Actual sample counts
remain in `perf report --show-nr-samples`. `flamegraph-metadata.json` records the
event, units, total folded weight, and interpretation. With constant periods,
weighted widths have the same proportions as raw sample-count widths.

Each SVG is normalized to its own total event-period weight. A function occupying 80%
of O3 versus 50% of O0 can still consume less absolute time after optimization.
Compare timing/sample totals as well as relative widths. X order is not time;
height is call depth. Inlining may remove frames while retaining equivalent work.
Colors are stable by symbol hash and do not encode measured temperature or cost.
For a label-only redraw that reuses already folded real data without recording,
decoding, or folding again, pass the source directory and `--reuse-folded`:

```bash
bash scripts/linux/render_flamegraph.sh results/linux-EXPERIMENT/profiles/image_o0 tools/FlameGraph --reuse-folded
```

## Energy domains and limits

Linux RAPL collection is available only if readable powercap package counters
exist. It reads `energy_uj` and `max_energy_range_uj`; it writes no sysfs settings.
Raw counter samples and advertised wrap ranges are saved. Negative successive
deltas add the advertised counter range. The explicit assumption is at most one
wrap per polling interval and no counter reset/suspend/driver change. The nominal
poll interval is 0.1 s; the maximum actual gap is recorded.

Only disjoint CPU package domains are summed. Core/uncore children are not added
to their package parents. `psys` is not added to packages. Ambiguous duplicate
drivers cause refusal. **CPU package energy is not whole-computer energy** and
is not a direct per-process counter. It can contain other processes, other cores,
integrated components, and measurement overhead depending on the hardware.

Energy is collected separately from perf/time. Each active window is bracketed
by two `--idle-seconds` reference windows (default three seconds each). The mean
of the two idle powers estimates background power:

```
estimated incremental package joules = active package joules
                                      - mean idle watts * active window seconds
```

This estimates the workload's incremental package contribution, subject to
background load, temperature, idle-state, and turbo/frequency drift. It is not
exact isolated-program energy. Negative estimates remain negative and are marked
unreliable. Do not silently clamp them to zero or label the estimate a direct
sensor measurement. The active sensor window includes launch/exit/sampling;
the raw interval boundaries are retained.

Average watts = measured joules / sensor-window seconds. A faster optimized
version may use more watts while consuming fewer joules for the same work.
Report those quantities and units separately. Run several paired experiments.

## Actual whole-system measurement

Whole-system input energy requires an actual meter at a defined boundary, such
as the desktop's AC wall input excluding its monitor. A CPU package/DRAM sum,
TDP, battery percentage, or guessed watts does not satisfy that measurement.
If there is no meter or documented whole-system sensor, report this requirement
as not measured. On laptops, charger input also includes battery charging;
document battery state and the physical measurement boundary.

For a logging wattmeter, export real `timestamp,power_w` CSV samples (epoch
seconds or timezone-aware ISO-8601), synchronize the meter and computer clocks,
and record an idle segment alongside the experiment. Import one measured run:

```bash
python3 scripts/linux/import_wattmeter.py real-meter.csv \
  --status-file results/linux-EXPERIMENT/time/01-image_o0.status.json \
  --idle-start 1792778400 --idle-end 1792778430 \
  --meter 'Actual model, logging mode, stated accuracy' \
  --scope 'AC input to entire desktop, monitor excluded' \
  --label 'image_o0 run 1' --output results/wattmeter-o0-1.json
```

The timestamps above are illustrative command arguments, not measurements.
Use actual idle boundaries from your trace. The importer refuses missing trace
coverage and sample gaps exceeding `--max-gap` (default two seconds). It integrates
by the trapezoidal rule with linear interpolation at window boundaries. It also
reports active-minus-idle system energy as an explicitly approximate application
estimate. Meter accuracy and clock uncertainty remain part of the analysis.

## Primary sources

- [GNU time](https://www.gnu.org/software/time/) — process time/resource statistics.
- [perf stat manual](https://man7.org/linux/man-pages/man1/perf-stat.1.html) —
  detailed counters, repeat measurements, and event semantics.
- [perf record manual](https://man7.org/linux/man-pages/man1/perf-record.1.html) and
  [perf report manual](https://man7.org/linux/man-pages/man1/perf-report.1.html) —
  profile recording and self/inclusive interpretation.
- [Official FlameGraph repository](https://github.com/brendangregg/FlameGraph) —
  capture, fold, render workflow and renderer source.
- [Linux powercap documentation](https://www.kernel.org/doc/html/latest/power/powercap/powercap.html) —
  domain hierarchy, energy counters, wrap range, and lack of instantaneous RAPL
  power attributes.
