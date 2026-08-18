# Parts

Companion material is organized as:

```text
parts/
  part-001/
  part-002/
  ...
  part-120/
```

Each implemented part directory contains a focused README plus runnable examples, tests, fixtures, or project overlays relevant to that part. Paid book prose is intentionally not copied into this public repository.

When a part requires external services, use safe `.env.example`/configuration placeholders rather than real credentials.

## Implementation status

| Part | Companion topic | Status |
|---|---|---|
| [001](part-001/) | Foundations, Installation, IDE Setup and Your First Applications | ✅ Runnable package + tests |
| [002](part-002/) | Dart Syntax, Variables, Constants and Core Types | ✅ Runnable package + tests |
| [003](part-003/) | Dart Operators, Expressions and Evaluation | ✅ Runnable package + tests |
| [004](part-004/) | Dart Control Flow, Switches, Patterns and Loops | ✅ Runnable package + tests |
| [005](part-005/) | Dart Functions, Callbacks, Closures and Functional Design | ✅ Runnable package + tests |
| [006](part-006/) | Dart Collections, Generics, Iterables and Data Transformation | ✅ Runnable package + tests |
| [007](part-007/) | Object-Oriented Dart and Professional Model Design | ✅ Runnable package + tests |
| [008](part-008/) | Exceptions, Failures, Logging and Resilient Applications | ✅ Runnable package + tests |
| [009](part-009/) | Asynchronous Dart: Futures, Streams, Isolates and Responsive Flutter | ✅ Runnable package + tests |
| [010](part-010/) | Dart Libraries, Packages, Pub and Reusable Architecture | ✅ Reusable package + tests |
| [011](part-011/) | Flutter Framework Architecture, Widgets and the UI Pipeline | ✅ Flutter package + widget tests |
| [012](part-012/) | Flutter Layout Mastery, Responsive Design and Slivers | ✅ Flutter package + widget tests |
| 013–120 | Remaining Flutter and advanced companion implementations | 🚧 Planned / incremental |

The table reflects what is actually present in GitHub; it does not claim unfinished companion packages are already published.

## Validate all implemented packages

From the repository root:

```bash
PACKAGE_KIND=dart REQUIRE_MATCH=1 bash scripts/validate-companion-packages.sh
PACKAGE_KIND=flutter REQUIRE_MATCH=1 bash scripts/validate-companion-packages.sh
```

GitHub Actions runs the Dart and Flutter toolchains separately so one ecosystem cannot hide failures in the other.

## Next implementation phase

Parts 013–020 continue with theming/design systems, forms, navigation, state management, networking, persistence, platform integration, and animation.

## Read the complete series

[![Get the complete edition on Gumroad](../assets/gumroad-badge.svg)](https://ramsandesh.gumroad.com)

The commercial **Dart & Flutter Full Mastery — Complete 120-Part Master Edition** and available bundles are highlighted on the official Gumroad storefront:

### 🛒 **https://ramsandesh.gumroad.com**

Official repository: **https://github.com/sanskarIN/dart-flutter-master**

GitHub remains the home for open companion material; Gumroad is the purchase/support destination for the reader editions and bundles.
