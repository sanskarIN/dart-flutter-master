# Changelog

All notable companion-repository changes should be recorded here.

## Unreleased

### Companion implementation

- Implement Parts 001–010 as standalone tested Dart companion packages in exact master-manuscript order.
- Implement Parts 011–020 as focused tested Flutter companion packages.
- Add companion coverage for Flutter widgets, responsive/sliver layout, design systems, forms, navigation, state management, REST architecture, offline-first persistence, platform channels, animations, and custom painting.
- Add an accurate implementation matrix in `parts/README.md`; unfinished parts are explicitly marked planned rather than implied complete.
- Add repository-wide package discovery and separate Dart/Flutter validation modes.
- Add dedicated Dart and Flutter GitHub Actions workflows.
- Add the Flutter companion package standard in `docs/FLUTTER_COMPANION_GUIDE.md`.

### Master projects

- Add **TaskFlow** for task/repository/controller architecture.
- Add **PocketLedger** for integer-money modeling, reporting, and local persistence.
- Add **NoteVault** for offline notes, tags, full-text search, and pin ordering.
- Add **API Explorer** for safe REST modeling, injected transports, response inspection, and request history.
- Add **HabitPulse** for normalized date keys, daily check-ins, and streak calculations.
- Add **QuizForge** for validated questions, deterministic scoring, progress, results, and restart flows.
- Add `master-projects/PROJECT_STANDARD.md` and `PROJECT_TEMPLATE.md` for future project consistency.
- Add `docs/MASTER_PROJECTS.md` with an architecture comparison and contribution guidance.
- Add master-project structure verification to Flutter CI.
- Extend canonical GitHub/Gumroad link enforcement to every master-project README.

### Final hardening and documentation

- Add `.editorconfig`, CODEOWNERS, Dependabot configuration, and `CITATION.cff`.
- Treat Dart/Flutter analyzer information findings as CI failures to surface deprecations and maintenance issues early.
- Add deterministic repository-quality checks for package manifests/tests, local Markdown links, shell syntax, canonical links, master-project structure, placeholder markers, and common committed-secret/config artifacts.
- Add the Repository Quality workflow and a manual/tag-triggered full Release Validation workflow.
- Add CI concurrency cancellation and explicit timeouts to prevent obsolete runs from consuming the queue.
- Add architecture, compatibility, testing, troubleshooting, accessibility, privacy/data-handling, dependency, versioning, release-process, maintainer, and FAQ documentation.
- Expand the README and documentation hub with validation commands, CI badges, support/security links, and the complete engineering/maintenance documentation set.
- Strengthen contribution, bug-report, feature-request, and pull-request templates with reproducibility, security, licensing, accessibility, and test requirements.
- Extend canonical-link enforcement to the complete reader-facing documentation set while continuing to reject X/Twitter profile URLs from canonical metadata.

### Repository and publication infrastructure

- Establish official repository structure and governance.
- Standardize canonical project URL to `https://github.com/sanskarIN/dart-flutter-master`.
- Add publishing, release, validation, errata, and contribution documentation.
- Add the official Gumroad storefront throughout reader-facing repository documentation: `https://ramsandesh.gumroad.com`.
- Add clickable Gumroad README branding and GitHub funding link.
- Enforce Gumroad/repository links across implemented part and master-project READMEs and reject X/Twitter profile URLs from canonical metadata.
- Prepare repository for the first public companion-code release.

## v1.0.0 — planned

- Companion material aligned with Parts 001–120.
- Examples, exercises, solutions, master projects, and interview-preparation material.
- Initial stable documentation and release checks.
- Prominent official-store routing for the complete commercial edition and bundles.
- Current stable Dart/Flutter validation completed before tagging.

## Official store

🛒 **https://ramsandesh.gumroad.com**

Official repository: **https://github.com/sanskarIN/dart-flutter-master**
