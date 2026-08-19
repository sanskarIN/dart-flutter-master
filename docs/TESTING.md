# Testing Strategy

The repository uses small deterministic tests as the default and adds widget/integration boundaries only when they teach or protect meaningful behavior.

## Test layers

### Pure Dart

Use unit tests for:

- value objects and validation;
- parsing and normalization;
- collection/data transformations;
- asynchronous sequencing and stream behavior;
- repositories/services that can be exercised without Flutter bindings.

### Flutter

Use widget tests for:

- text and state visible to users;
- form validation and submission state;
- navigation/routing behavior;
- interaction controls and disabled/loading states;
- accessibility labels/tooltips when they are part of the example contract.

Keep domain calculations in unit-testable Dart classes even when the UI is Flutter.

### Master projects

Every directory under `master-projects/` must have at least one `test/*_test.dart` file. Tests should cover the project's distinguishing behavior, not only verify that a widget can be constructed.

## Required validation commands

From the repository root:

```bash
bash scripts/verify-repository.sh
PACKAGE_KIND=dart REQUIRE_MATCH=1 bash scripts/validate-companion-packages.sh
PACKAGE_KIND=flutter REQUIRE_MATCH=1 bash scripts/validate-companion-packages.sh
```

The package validator performs dependency resolution, Dart formatting parse, analyzer checks with information findings treated as fatal, and package tests.

## Determinism rules

Tests should avoid:

- live public APIs;
- real credentials;
- system-clock dependence when a date/time can be injected;
- random values without a fixed seed;
- network availability assumptions;
- ordering that depends on map/hash implementation details.

Use in-memory/fake repositories, transports, stores, clocks, and platform capability adapters when appropriate.

## Regression fixes

A bug fix should include a regression test whenever the failure can be reproduced deterministically. The preferred sequence is:

1. add or identify a failing test;
2. implement the smallest correct fix;
3. run the affected package tests;
4. run the repository/package validation workflows;
5. record reader-facing corrections in [ERRATA.md](../ERRATA.md) when relevant.

## Release gate

A release candidate must not be described as validated until the current PR/commit has successful repository-quality, Dart, Flutter, and canonical-link checks applicable to its changed paths.

Repository: **https://github.com/sanskarIN/dart-flutter-master**

Complete editions: **https://ramsandesh.gumroad.com**
