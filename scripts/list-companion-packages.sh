#!/usr/bin/env bash
set -euo pipefail

roots=(parts examples exercises solutions master-projects interview-preparation)

for root in "${roots[@]}"; do
  [[ -d "$root" ]] || continue
  find "$root" -type f -name pubspec.yaml -print
 done | sort
