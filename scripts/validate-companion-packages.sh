#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

mapfile -t manifests < <(bash scripts/list-companion-packages.sh)

if (( ${#manifests[@]} == 0 )); then
  echo 'No companion pubspec.yaml files found.' >&2
  exit 1
fi

echo "Discovered ${#manifests[@]} companion package(s)."

for manifest in "${manifests[@]}"; do
  package_dir="$(dirname "$manifest")"
  echo
  echo "==> Validating $package_dir"

  pushd "$package_dir" >/dev/null

  if grep -Eq '^[[:space:]]+sdk:[[:space:]]+flutter[[:space:]]*$' pubspec.yaml; then
    if ! command -v flutter >/dev/null 2>&1; then
      echo "Flutter SDK is required for $package_dir but is not available." >&2
      exit 1
    fi
    flutter pub get
    dart format --output=none --set-exit-if-changed .
    flutter analyze
    if [[ -d test ]] && find test -type f -name '*_test.dart' -print -quit | grep -q .; then
      flutter test
    fi
  else
    if ! command -v dart >/dev/null 2>&1; then
      echo 'Dart SDK is required but is not available.' >&2
      exit 1
    fi
    dart pub get
    dart format --output=none --set-exit-if-changed .
    dart analyze
    if [[ -d test ]] && find test -type f -name '*_test.dart' -print -quit | grep -q .; then
      dart test
    fi
  fi

  popd >/dev/null
 done

echo
echo 'All companion packages passed validation.'
