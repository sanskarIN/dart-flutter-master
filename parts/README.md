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
| 011–120 | Remaining Flutter and advanced companion implementations | 🚧 Planned / incremental |

The table reflects what is actually present in GitHub; it does not claim unfinished companion packages are already published.

## Validate all implemented packages

From the repository root:

```bash
bash scripts/list-companion-packages.sh
bash scripts/validate-companion-packages.sh
```

The repository CI runs the same validation for relevant pushes and pull requests.

## Next implementation phase

Parts 011–020 move into Flutter framework architecture, layouts, theming, forms, navigation, state management, networking, persistence, platform integration, and animation. Flutter-specific validation will use a dedicated workflow so pure-Dart package checks remain fast and isolated.

## Read the complete series

[![Get the complete edition on Gumroad](../assets/gumroad-badge.svg)](https://ramsandesh.gumroad.com)

The commercial **Dart & Flutter Full Mastery — Complete 120-Part Master Edition** and available bundles are highlighted on the official Gumroad storefront:

### 🛒 **https://ramsandesh.gumroad.com**

Official repository: **https://github.com/sanskarIN/dart-flutter-master**

GitHub remains the home for open companion material; Gumroad is the purchase/support destination for the reader editions and bundles.
