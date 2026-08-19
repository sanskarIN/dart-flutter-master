# Companion Repository Roadmap

## Phase 1 — Repository foundation ✅

- Governance and licensing
- Documentation structure
- Errata and changelog workflow
- Release/validation checklists
- Official Gumroad storefront integration
- Canonical-link CI and repository policies

## Phase 2 — Parts 001–020 ✅

Implemented manuscript-aligned companion packages for:

- Dart foundations, syntax, operators, control flow, functions, collections, OOP, resilience, async, and package architecture.
- Flutter widget architecture, responsive/sliver layouts, design systems, forms, navigation, state management, REST/data architecture, offline-first persistence, platform capability boundaries, animations, and custom painting.
- Unit/widget tests appropriate to each implemented part.
- Separate Dart and Flutter GitHub Actions validation paths.

See `parts/README.md` for the exact implementation matrix.

## Master-project expansion ✅ initial collection

Six standalone Flutter projects are now available under `master-projects/`:

- TaskFlow
- PocketLedger
- NoteVault
- API Explorer
- HabitPulse
- QuizForge

Each project has its own package manifest, README, app entry point, architecture layers, and tests. Flutter CI discovers these packages automatically, and a separate structure verifier prevents incomplete project folders from being treated as finished.

Future master projects may continue alongside the manuscript implementation phases when they teach a distinct architecture pattern and meet `master-projects/PROJECT_STANDARD.md`.

## Phase 3 — Parts 021–060 🚧 next

Continue in exact master-manuscript order with advanced Flutter UI, testing, architecture, data, performance, and production companion implementations.

## Phase 4 — Parts 061–100

Add advanced application, framework, platform, integration, and enterprise material.

## Phase 5 — Parts 101–120

Add platform integrations, additional master projects, open-source/career material, interview preparation, and final assessment assets.

## Phase 6 — v1.0.0

Run current stable Dart/Flutter analysis and tests, verify supported platforms, close confirmed errata, and publish a signed/tagged release with checksums.

## Phase 7 — Distribution and reader updates

- Keep the GitHub repository as the canonical home for open companion code and public errata.
- Highlight the official Gumroad storefront in reader-facing documentation.
- Keep Gumroad commercial bundles aligned with stable publication versions.
- Link Gumroad buyers back to GitHub for code, changelog, errata, and release notes.

### 🛒 Official Gumroad

**https://ramsandesh.gumroad.com**

Official repository: **https://github.com/sanskarIN/dart-flutter-master**

The commercial book files are distributed through publication channels rather than committed to this public code repository.
