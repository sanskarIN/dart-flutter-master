# Master Projects

[![Gumroad](../assets/gumroad-badge.svg)](https://ramsandesh.gumroad.com)

This directory contains production-minded, credential-free companion projects for **Dart & Flutter Full Mastery**. Each project is intentionally small enough to study while still demonstrating real architecture boundaries, testability, validation, failure handling, and maintainable Flutter code.

## Project catalog

| Project | Focus | Status |
|---|---|---|
| [TaskFlow](taskflow/) | Task management, filters, priorities, repository/controller architecture | ✅ Package + tests |
| [PocketLedger](pocketledger/) | Integer-money modeling, reporting, local persistence, finance UI | ✅ Package + tests |
| [NoteVault](notevault/) | Offline notes, search, tags, pinning, local repository state | ✅ Package + tests |
| [API Explorer](api-explorer/) | REST modeling, injected transport, response inspection, request history | ✅ Package + tests |
| [HabitPulse](habitpulse/) | Daily habits, normalized date keys, streaks, progress state | ✅ Package + tests |
| [QuizForge](quizforge/) | Question modeling, scoring, progress, result/restart flows | ✅ Package + tests |

## Validation

From the repository root:

```bash
PACKAGE_KIND=flutter REQUIRE_MATCH=1 bash scripts/validate-companion-packages.sh
```

The Flutter Companion CI workflow also watches `master-projects/**`, and package discovery scans this directory automatically.

## Project requirements

Each project should document and demonstrate:

- product/domain scope
- architecture and dependency boundaries
- setup and validation commands
- testing strategy
- security/privacy notes where relevant
- accessibility expectations
- failure/recovery behavior
- deterministic demo adapters
- no committed secrets or credentials
- official repository and Gumroad links

See [PROJECT_STANDARD.md](PROJECT_STANDARD.md) before adding another master project.

## Complete master-project learning path

The commercial **Dart & Flutter Full Mastery** editions and bundles that accompany these projects are available from the official Gumroad storefront:

### 🛒 **https://ramsandesh.gumroad.com**

Official repository: **https://github.com/sanskarIN/dart-flutter-master**

Use GitHub for the public project scaffolds and Gumroad for the complete reader/bundle editions.
