# Dependency Management Policy

Dependencies are kept intentionally small so the repository teaches Dart/Flutter concepts rather than framework-specific glue.

## Rules

1. Prefer Dart/Flutter SDK functionality when it is clear and sufficient.
2. Add a third-party package only when it materially improves the lesson/project or models a real production boundary.
3. Never use `any` as a committed dependency constraint.
4. Keep package constraints compatible with the supported stable SDK policy in [COMPATIBILITY.md](COMPATIBILITY.md).
5. Avoid adding two packages that solve the same problem without a documented comparison reason.
6. Do not commit credentials required by a dependency or hosted service.
7. Review licenses before adding dependencies to public MIT-licensed companion source.

## Version updates

Dependabot is configured for GitHub Actions and Pub package manifests. Automated update PRs still require normal CI validation; an available newer version is not sufficient reason to merge a breaking update.

For dependency updates:

- inspect release notes for breaking/deprecated APIs;
- run the affected package's analyzer/tests;
- run repository validation;
- update examples/docs when public APIs changed;
- record meaningful compatibility changes in [CHANGELOG.md](../CHANGELOG.md).

## Lockfiles

Educational package lockfiles may be omitted when the package is intended to demonstrate a library-style constraint surface. Application-style projects may commit lockfiles when reproducible application dependency resolution becomes part of the project contract.

Do not mix lockfile policies accidentally within the same project.

## Supply-chain review

New dependencies should be evaluated for:

- active maintenance and compatibility;
- license compatibility;
- unnecessary transitive dependencies;
- network/native-code behavior;
- security advisories;
- whether a small local abstraction can keep the educational core testable.

## Canonical links

Repository: **https://github.com/sanskarIN/dart-flutter-master**

Complete editions: **https://ramsandesh.gumroad.com**
