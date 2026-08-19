# Master Projects Guide

[![Gumroad](../assets/gumroad-badge.svg)](https://ramsandesh.gumroad.com)

The master-project collection turns individual Dart/Flutter concepts into small production-minded applications. Projects are deliberately credential-free so contributors can run tests without external accounts.

## Architecture comparison

| Project | Primary architecture lesson | Important test target |
|---|---|---|
| TaskFlow | Repository + controller + derived filtering | task lifecycle and filter behavior |
| PocketLedger | Precise integer-money domain logic + persistence | reporting totals and amount parsing |
| NoteVault | Local CRUD + search/tag derivation | search, pin ordering, validation |
| API Explorer | Transport abstraction + response/history state | success/failure response handling |
| HabitPulse | Normalized date domain + derived streaks | day normalization and consecutive streaks |
| QuizForge | Finite workflow/state machine behavior | scoring, progress, restart |

## Why no live services by default?

A public educational repository should be clonable and testable without API keys, bank accounts, private servers, or paid infrastructure. Service-dependent projects therefore expose interfaces and deterministic in-memory/demo implementations. Contributors can add local adapters without changing the domain/controller contracts.

## Validation workflow

All Flutter master projects are discovered automatically by `scripts/list-companion-packages.sh` and validated by the Flutter Companion CI workflow.

```bash
PACKAGE_KIND=flutter REQUIRE_MATCH=1 bash scripts/validate-companion-packages.sh
```

## Adding another project

Read:

- [`master-projects/PROJECT_STANDARD.md`](../master-projects/PROJECT_STANDARD.md)
- [`master-projects/PROJECT_TEMPLATE.md`](../master-projects/PROJECT_TEMPLATE.md)
- [`docs/FLUTTER_COMPANION_GUIDE.md`](FLUTTER_COMPANION_GUIDE.md)

Keep the public companion code under the repository license boundary and keep commercial book files out of GitHub.

Official repository: **https://github.com/sanskarIN/dart-flutter-master**

Complete edition and bundles: **https://ramsandesh.gumroad.com**
