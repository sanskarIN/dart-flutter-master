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
  docs/ACCESSIBILITY.md
  docs/ARCHITECTURE.md
  docs/BOOK_METADATA.md
  docs/COMPATIBILITY.md
  docs/DEPENDENCY_POLICY.md
  docs/FAQ.md
  docs/FLUTTER_COMPANION_GUIDE.md
  docs/MAINTAINERS.md
  docs/MASTER_PROJECTS.md
  docs/PRIVACY.md
  docs/PUBLISHING.md
  docs/RELEASE_PROCESS.md
  docs/TESTING.md
  docs/TROUBLESHOOTING.md
  docs/VERSIONING.md
  docs/GUMROAD_PRODUCT_GUIDE.md
  docs/GUMROAD_RELEASE_CHECKLIST.md
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
  master-projects/PROJECT_STANDARD.md
  master-projects/PROJECT_TEMPLATE.md
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
  docs/ACCESSIBILITY.md
  docs/ARCHITECTURE.md
  docs/BOOK_METADATA.md
  docs/COMPATIBILITY.md
  docs/DEPENDENCY_POLICY.md
  docs/FAQ.md
  docs/FLUTTER_COMPANION_GUIDE.md
  docs/MAINTAINERS.md
  docs/MASTER_PROJECTS.md
  docs/PRIVACY.md
  docs/PUBLISHING.md
  docs/RELEASE_PROCESS.md
  docs/TESTING.md
  docs/TROUBLESHOOTING.md
  docs/VERSIONING.md
  docs/GUMROAD_PRODUCT_GUIDE.md
  docs/GUMROAD_RELEASE_CHECKLIST.md
  docs/REPOSITORY_POLICY.md
  docs/STORE_LINK_POLICY.md
  master-projects/README.md
  master-projects/PROJECT_STANDARD.md
  master-projects/PROJECT_TEMPLATE.md
)

for file in "${repo_files[@]}"; do
  if ! grep -Fq "$REPOSITORY" "$file"; then
    echo "Missing canonical repository URL in: $file" >&2
    exit 1
  fi
done

shopt -s nullglob
part_readmes=(parts/part-*/README.md)
project_readmes=(master-projects/*/README.md)

for file in "${part_readmes[@]}"; do
  if ! grep -Fq "$GUMROAD" "$file"; then
    echo "Missing Gumroad link in implemented part: $file" >&2
    exit 1
  fi
  if ! grep -Fq "$REPOSITORY" "$file"; then
    echo "Missing canonical repository URL in implemented part: $file" >&2
    exit 1
  fi
done

for file in "${project_readmes[@]}"; do
  if ! grep -Fq "$GUMROAD" "$file"; then
    echo "Missing Gumroad link in master project: $file" >&2
    exit 1
  fi
  if ! grep -Fq "$REPOSITORY" "$file"; then
    echo "Missing canonical repository URL in master project: $file" >&2
    exit 1
  fi
done

if grep -RniE --include='*.md' --include='*.yml' --include='*.yaml' '(https?://)?(www\.)?(x\.com|twitter\.com)/' . \
  --exclude-dir='.git'; then
  echo 'A changeable X/Twitter profile URL was found. Remove it from canonical repository metadata.' >&2
  exit 1
fi

echo 'Canonical link verification passed.'
echo "Checked ${#reader_files[@]} required reader-facing file(s)."
echo "Checked ${#part_readmes[@]} implemented part README file(s)."
echo "Checked ${#project_readmes[@]} master-project README file(s)."
echo "Gumroad: $GUMROAD"
echo "Repository: $REPOSITORY"
