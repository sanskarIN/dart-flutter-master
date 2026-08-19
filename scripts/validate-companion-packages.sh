#!/usr/bin/env bash
set -euo pipefail

export CI=true

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

package_kind="${PACKAGE_KIND:-all}"
require_match="${REQUIRE_MATCH:-0}"

case "$package_kind" in
  all|dart|flutter) ;;
  *)
    echo "Unsupported PACKAGE_KIND: $package_kind (expected all, dart, or flutter)." >&2
    exit 2
    ;;
esac

mapfile -t manifests < <(bash scripts/list-companion-packages.sh)

if (( ${#manifests[@]} == 0 )); then
  echo 'No companion pubspec.yaml files found.' >&2
  exit 1
fi

echo "Discovered ${#manifests[@]} companion package manifest(s)."
echo "Validation mode: $package_kind"

validated=0

for manifest in "${manifests[@]}"; do
  package_dir="$(dirname "$manifest")"
  is_flutter=0

  if grep -Eq '^[[:space:]]+sdk:[[:space:]]+flutter[[:space:]]*$' "$manifest"; then
    is_flutter=1
  fi

  if [[ "$package_kind" == 'dart' && "$is_flutter" == '1' ]]; then
    continue
  fi
  if [[ "$package_kind" == 'flutter' && "$is_flutter" == '0' ]]; then
    continue
  fi

  ((validated += 1))
  echo
  echo "==> Validating $package_dir"

  pushd "$package_dir" >/dev/null

  if [[ "$is_flutter" == '1' ]]; then
    if ! command -v flutter >/dev/null 2>&1; then
      echo "Flutter SDK is required for $package_dir but is not available." >&2
      exit 1
    fi
    flutter pub get
    dart format --output=none .
    flutter analyze --fatal-infos
    if [[ -d test ]] && find test -type f -name '*_test.dart' -print -quit | grep -q .; then
      flutter test
    fi
  else
    if ! command -v dart >/dev/null 2>&1; then
      echo 'Dart SDK is required but is not available.' >&2
      exit 1
    fi
    dart pub get
    dart format --output=none .
    dart analyze --fatal-infos
    if [[ -d test ]] && find test -type f -name '*_test.dart' -print -quit | grep -q .; then
      dart test
    fi
  fi

  popd >/dev/null
done

if (( validated == 0 )); then
  message="No $package_kind companion packages matched the selected validation mode."
  if [[ "$require_match" == '1' ]]; then
    echo "$message" >&2
    exit 1
  fi
  echo "$message"
  exit 0
fi

echo
echo "All $validated selected companion package(s) passed validation."
