# Maintainer Operations Guide

## Maintainer responsibility

Maintainers protect correctness, the public/commercial licensing boundary, repository security, and the alignment between companion code and the book series.

Primary repository owner: `@sanskarIN`.

## Review priorities

Review changes in this order:

1. security/privacy and credential exposure;
2. compile/analyzer/test correctness;
3. manuscript/part alignment;
4. public API and compatibility impact;
5. accessibility and failure behavior;
6. documentation and release metadata;
7. formatting/style.

## Merge discipline

- Prefer focused commits with descriptive messages.
- Do not merge a PR with known failing applicable checks.
- Do not describe a path/platform as tested when it was not exercised.
- Require a regression test for reproducible defects when practical.
- Keep generated publication binaries out of the public code repository.

## Issue triage

Classify reports as one of:

- code defect;
- documentation/book erratum;
- compatibility/dependency regression;
- feature/example request;
- security report (move to the private process in [SECURITY.md](../SECURITY.md));
- support question.

Ask for a minimal reproduction and current tool versions before treating environment-specific failures as repository bugs.

## Dependency maintenance

Dependabot PRs require the same analyzer/test gates as human changes. Do not merge only because a dependency is newer.

## Release ownership

Use [RELEASE_PROCESS.md](RELEASE_PROCESS.md) and [RELEASE_CHECKLIST.md](RELEASE_CHECKLIST.md). Release tags should point to the exact validated `main` commit.

## Continuity

If maintenance pauses, update the README/roadmap rather than leaving users to infer support. If the repository is ever archived, document the final compatible toolchain and security/support status.

Repository: **https://github.com/sanskarIN/dart-flutter-master**

Complete editions: **https://ramsandesh.gumroad.com**
