#!/usr/bin/env bash
# Explicit opt-in public-source download. No installation or privileged changes.
set -euo pipefail
root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../.." && pwd)"
revision=41fee1f99f9276008b7cd112fca19dc3ea84ac32
destination="$root/tools/FlameGraph"
if [[ -e "$destination" ]]; then
  current="$(git -C "$destination" rev-parse HEAD 2>/dev/null || true)"
  if [[ "$current" != "$revision" ]]; then
    echo "Existing tools/FlameGraph differs from pinned revision; nothing changed." >&2
    exit 1
  fi
  echo "Pinned FlameGraph source already present: $revision"
  exit 0
fi
mkdir -p "$root/tools"
git clone --no-checkout https://github.com/brendangregg/FlameGraph.git "$destination"
git -C "$destination" checkout --detach "$revision"
test "$(git -C "$destination" rev-parse HEAD)" = "$revision"
echo "Downloaded official FlameGraph source at $revision"
