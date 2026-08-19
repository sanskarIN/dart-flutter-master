# Release Process

This document turns the release checklist into an ordered maintenance workflow.

## 1. Prepare

- ensure `main` contains the intended companion code and documentation;
- close or explicitly defer confirmed release-blocking bugs;
- review [ERRATA.md](../ERRATA.md) for book/code synchronization needs;
- verify canonical GitHub and Gumroad links;
- confirm no commercial publication binaries are being committed to the public code repository.

## 2. Validate through a pull request

Run the release work through a PR so GitHub Actions can validate the exact merge candidate.

Required applicable checks:

- Repository Quality;
- Canonical Links;
- Dart Companion CI;
- Flutter Companion CI.

A check that did not run because its path filter was irrelevant is different from a failed check. For a broad release PR, touch/run the shared validation layer so both code ecosystems are exercised.

## 3. Local verification when available

```bash
bash scripts/verify-repository.sh
PACKAGE_KIND=dart REQUIRE_MATCH=1 bash scripts/validate-companion-packages.sh
PACKAGE_KIND=flutter REQUIRE_MATCH=1 bash scripts/validate-companion-packages.sh
```

For platform-specific applications, additionally build/test only the targets explicitly documented as supported.

## 4. Version and changelog

- choose a SemVer release version for the public companion repository;
- move relevant `Unreleased` changelog entries into the release section;
- record compatibility/dependency changes;
- keep publication-edition versioning separate when the book requires a different revision scheme.

See [VERSIONING.md](VERSIONING.md).

## 5. Merge and tag

Merge only the commit that passed the release validation. Create an annotated release tag from the resulting `main` commit and write release notes from the changelog, errata, and implemented milestone.

## 6. Distribution synchronization

GitHub remains the source for open companion code and public errata. Commercial reader bundles are distributed separately. When a release changes companion files referenced by the book, update the matching reader bundle/release notes on the official store.

## 7. Post-release

- verify the tag/release points to the expected commit;
- verify downloadable/source links;
- reopen `Unreleased` changelog work for the next cycle;
- monitor new reproducible regressions and security reports.

Existing checklist: [RELEASE_CHECKLIST.md](RELEASE_CHECKLIST.md)

Repository: **https://github.com/sanskarIN/dart-flutter-master**

Complete editions: **https://ramsandesh.gumroad.com**
