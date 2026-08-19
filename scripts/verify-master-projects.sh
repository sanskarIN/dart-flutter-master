#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

shopt -s nullglob
projects=(master-projects/*/pubspec.yaml)

if (( ${#projects[@]} == 0 )); then
  echo 'No master-project pubspec.yaml files found.' >&2
  exit 1
fi

for manifest in "${projects[@]}"; do
  project_dir="$(dirname "$manifest")"
  echo "Verifying $project_dir"

  [[ -f "$project_dir/README.md" ]] || {
    echo "Missing README.md: $project_dir" >&2
    exit 1
  }
  [[ -f "$project_dir/lib/main.dart" ]] || {
    echo "Missing lib/main.dart: $project_dir" >&2
    exit 1
  }
  if [[ ! -d "$project_dir/test" ]] || ! find "$project_dir/test" -type f -name '*_test.dart' -print -quit | grep -q .; then
    echo "Missing test/*_test.dart: $project_dir" >&2
    exit 1
  fi

done

echo "Verified ${#projects[@]} master project package(s)."
