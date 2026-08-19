#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

patterns=(
  '-----BEGIN ([A-Z0-9 ]+ )?PRIVATE KEY-----'
  'AKIA[0-9A-Z]{16}'
  'github_pat_[A-Za-z0-9_]{20,}'
  'gh[pousr]_[A-Za-z0-9]{20,}'
  'AIza[0-9A-Za-z_-]{30,}'
  'sk-[A-Za-z0-9_-]{20,}'
)

for pattern in "${patterns[@]}"; do
  if grep -IRniE "$pattern" . \
    --exclude-dir=.git \
    --exclude-dir=.dart_tool \
    --exclude-dir=build \
    --exclude='verify-no-secrets.sh'; then
    echo "Potential committed secret matched pattern: $pattern" >&2
    exit 1
  fi
done

while IFS= read -r path; do
  case "$path" in
    */.env.example|*/.env.sample|./.env.example|./.env.sample) continue ;;
  esac
  echo "Sensitive generated/configuration artifact must not be committed: $path" >&2
  exit 1
done < <(
  find . -type f \( \
    -name '.env' -o \
    -name '*.pem' -o \
    -name '*.p12' -o \
    -name '*.pfx' -o \
    -name '*.jks' -o \
    -name '*.keystore' -o \
    -name 'google-services.json' -o \
    -name 'GoogleService-Info.plist' \
  \) \
    -not -path './.git/*' \
    -not -path '*/.dart_tool/*' \
    -not -path '*/build/*'
)

echo 'No committed secret patterns or sensitive generated configuration artifacts detected.'
