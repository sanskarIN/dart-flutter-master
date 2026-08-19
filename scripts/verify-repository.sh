#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

printf '\n==> Shell syntax\n'
while IFS= read -r script; do
  bash -n "$script"
done < <(find scripts -maxdepth 1 -type f -name '*.sh' -print | sort)

printf '\n==> Canonical reader links\n'
bash scripts/verify-canonical-links.sh

printf '\n==> Master-project structure\n'
bash scripts/verify-master-projects.sh

printf '\n==> Package manifests and tests\n'
python3 scripts/verify-pubspecs.py

printf '\n==> Local Markdown links\n'
python3 scripts/verify-markdown-links.py

printf '\n==> Secret/config artifact guard\n'
bash scripts/verify-no-secrets.sh

printf '\n==> Placeholder markers\n'
if grep -RniE '\b(TODO|FIXME|HACK|XXX)\b' parts master-projects scripts \
  --include='*.dart' --include='*.py' --include='*.sh' \
  --exclude-dir=.dart_tool --exclude-dir=build; then
  echo 'Unresolved placeholder marker found in executable/project source.' >&2
  exit 1
fi

echo
echo 'Repository quality verification passed.'
