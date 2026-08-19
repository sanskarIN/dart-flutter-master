# Versioning and Deprecation Policy

## Repository releases

Public companion-code releases use Semantic Versioning (`MAJOR.MINOR.PATCH`) once the repository enters its first stable release line.

- **MAJOR** — intentionally breaking public companion APIs, project structure, or supported workflows.
- **MINOR** — backward-compatible new companion parts, projects, examples, or meaningful features.
- **PATCH** — fixes, compatible dependency/API migrations, documentation corrections, and errata-aligned code updates.

Before `v1.0.0`, development versions may change quickly; the changelog must still describe meaningful changes.

## Book/publication versions

Book editions and store bundles may use an edition/revision date in addition to repository SemVer. Do not assume that a repository patch number and a book edition number are interchangeable.

When code changes invalidate book instructions, record the correction in [ERRATA.md](../ERRATA.md) and update the affected publication bundle at the next appropriate release.

## Deprecation

Prefer migration before removal:

1. stop introducing new uses of a deprecated API;
2. replace existing uses on current stable Dart/Flutter when practical;
3. document behavior changes when the replacement changes the lesson;
4. remove compatibility shims only after their educational value is exhausted.

CI runs analyzer information findings as fatal in the companion package validator so deprecations surfaced by the current toolchain are treated as maintenance work rather than silently ignored.

## Version constraints

Committed dependencies must use explicit compatible constraints; `any` is prohibited by repository verification. SDK lower bounds must be declared in every package.

See [DEPENDENCY_POLICY.md](DEPENDENCY_POLICY.md) and [COMPATIBILITY.md](COMPATIBILITY.md).

Repository: **https://github.com/sanskarIN/dart-flutter-master**

Complete editions: **https://ramsandesh.gumroad.com**
