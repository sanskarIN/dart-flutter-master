#!/usr/bin/env bash
set -euo pipefail

GUMROAD='https://ramsandesh.gumroad.com'
REPOSITORY='https://github.com/sanskarIN/dart-flutter-master'

reader_files=(
  README.md
  GUMROAD.md
  SUPPORT.md
  BOOK_LICENSE.md
  CHANGELOG.md
  ERRATA.md
  docs/README.md
  docs/BOOK_METADATA.md
  docs/PUBLISHING.md
  docs/ROADMAP.md
  docs/RELEASE_CHECKLIST.md
  docs/REPOSITORY_POLICY.md
  docs/STORE_LINK_POLICY.md
  assets/README.md
  parts/README.md
  examples/README.md
  exercises/README.md
  solutions/README.md
  master-projects/README.md
  interview-preparation/README.md
  release-assets/README.md
)

for file in "${reader_files[@]}"; do
  if [[ ! -f "$file" ]]; then
    echo "Missing required reader-facing file: $file" >&2
    exit 1
  fi
  if ! grep -Fq "$GUMROAD" "$file"; then
    echo "Missing Gumroad link in: $file" >&2
    exit 1
  fi
done

repo_files=(
  README.md
  GUMROAD.md
  SUPPORT.md
  docs/README.md
  docs/BOOK_METADATA.md
  docs/PUBLISHING.md
  docs/REPOSITORY_POLICY.md
  docs/STORE_LINK_POLICY.md
)

for file in "${repo_files[@]}"; do
  if ! grep -Fq "$REPOSITORY" "$file"; then
    echo "Missing canonical repository URL in: $file" >&2
    exit 1
  fi
done

if grep -RniE --include='*.md' --include='*.yml' --include='*.yaml' '(https?://)?(www\.)?(x\.com|twitter\.com)/' . \
  --exclude-dir='.git'; then
  echo 'A changeable X/Twitter profile URL was found. Remove it from canonical repository metadata.' >&2
  exit 1
fi

echo 'Canonical link verification passed.'
echo "Gumroad: $GUMROAD"
echo "Repository: $REPOSITORY"
