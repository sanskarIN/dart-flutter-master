# Repository Architecture

This repository is a monorepo of educational Dart/Flutter companion packages plus production-minded master projects.

## Top-level boundaries

- `parts/` — manuscript-aligned companion packages. Parts 001–010 are pure Dart; Parts 011+ may use Flutter when required by the chapter.
- `master-projects/` — larger self-contained Flutter applications with domain, state/controller, storage/service, UI, and test boundaries.
- `examples/` — reusable examples that are not tied to one part.
- `exercises/` and `solutions/` — practice material kept separate so learners can work before reading reference solutions.
- `interview-preparation/` — interview-focused public companion material.
- `scripts/` — repository validation and release-quality checks.
- `.github/workflows/` — independent Dart, Flutter, canonical-link, and repository-quality CI.

## Package architecture

Every package should keep business/domain logic separate from UI when the topic justifies it. A typical Flutter project uses:

```text
lib/
  main.dart
  app.dart
  <domain>.dart
  <controller-or-state>.dart
  <repository-or-service>.dart

test/
  *_test.dart
```

Small educational parts may intentionally use fewer files when additional abstraction would obscure the concept being taught.

## Dependency direction

Preferred dependency direction is:

```text
UI -> controller/state -> repository/service abstraction -> implementation
                     -> domain/value objects
```

Domain models should not depend on widgets. Storage/network/platform adapters should be replaceable in tests. Public examples must not require committed credentials.

## CI architecture

- Dart packages are discovered and validated independently from Flutter packages.
- Flutter validation includes master-project structure checks.
- Repository quality validates manifests, local Markdown links, canonical reader links, secret/config artifacts, shell syntax, and placeholder markers.
- CI uses concurrency cancellation so superseded commits do not consume the queue unnecessarily.

## Commercial/public boundary

GitHub contains MIT-licensed companion source unless a file states otherwise. The commercial book manuscript, publication PDFs/EPUBs, covers, and publication artwork are governed separately by [BOOK_LICENSE.md](../BOOK_LICENSE.md).

## Canonical links

Official repository: **https://github.com/sanskarIN/dart-flutter-master**

Complete editions and bundles: **https://ramsandesh.gumroad.com**
