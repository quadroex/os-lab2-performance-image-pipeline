#!/usr/bin/env bash
# Convert one real perf profile. Keep all intermediary files for the live defense.
set -euo pipefail
if [[ $# -lt 1 || $# -gt 3 || ( $# -eq 3 && "$3" != --reuse-folded ) ]]; then
  echo "Usage: bash scripts/linux/render_flamegraph.sh PROFILE_DIR [FLAMEGRAPH_DIR] [--reuse-folded]" >&2
  exit 2
fi
root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../.." && pwd)"
profile="$(cd -- "$1" && pwd)"
source_dir="${2:-$root/tools/FlameGraph}"
revision=41fee1f99f9276008b7cd112fca19dc3ea84ac32
actual="$(git -C "$source_dir" rev-parse HEAD)"
if [[ "$actual" != "$revision" ]]; then
  echo "FlameGraph must be pinned to $revision; found $actual." >&2
  exit 1
fi
if [[ -n "$(git -C "$source_dir" status --porcelain)" ]]; then
  echo "FlameGraph source has local changes; refusing unrecorded renderer changes." >&2
  exit 1
fi
if [[ "${3:-}" != --reuse-folded ]]; then
  "${PERF:-perf}" script -i "$profile/perf.data" > "$profile/stacks.stdout.txt" 2> "$profile/stacks-render.stderr.txt"
  test -s "$profile/stacks.stdout.txt"
  perl "$source_dir/stackcollapse-perf.pl" "$profile/stacks.stdout.txt" > "$profile/stacks.folded" 2> "$profile/collapse.stderr.txt"
fi
test -s "$profile/stacks.folded"
countname="$(python3 - "$profile" <<'PY'
import json, sys
from pathlib import Path
p = Path(sys.argv[1])
record = json.loads((p / 'record.status.json').read_text())
argv = record['argv']
event = argv[argv.index('-e') + 1] if '-e' in argv else 'unknown'
units = 'nanoseconds' if event.split(':')[0] in ('cpu-clock', 'task-clock') else 'event weight'
weight = sum(int(line.rsplit(' ', 1)[1]) for line in (p / 'stacks.folded').read_text().splitlines() if line.strip())
(p / 'flamegraph-metadata.json').write_text(json.dumps({
    'event': event, 'count_units': units, 'total_folded_event_weight': weight,
    'folding': 'stackcollapse-perf.pl sums sample periods when perf script includes a period field; otherwise counts samples.',
    'raw_sample_count_source': 'report.stdout.txt: Samples and --show-nr-samples columns',
    'normalization': 'Each SVG normalizes widths to its own total event-period weight.'
}, indent=2) + '\n')
print(units)
PY
)"
perl "$source_dir/flamegraph.pl" --hash --countname "$countname" --title "CPU FlameGraph: $(basename -- "$profile")" --subtitle "Period-weighted CPU profile; widths normalized per graph; raw sample counts are in perf report" "$profile/stacks.folded" > "$profile/flamegraph.svg" 2> "$profile/render.stderr.txt"
printf '%s\n' "$actual" > "$profile/flamegraph-source-revision.txt"
echo "$profile/flamegraph.svg"
