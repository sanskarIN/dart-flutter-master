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
| [001](part-001/) | First program and core syntax | ✅ Runnable package + tests |
| [002](part-002/) | Types, null safety, and data modeling | ✅ Runnable package + tests |
| [003](part-003/) | Control flow and iteration | ✅ Runnable package + tests |
| [004](part-004/) | Functions, callbacks, and closures | ✅ Runnable package + tests |
| [005](part-005/) | Collections and data transformation | ✅ Runnable package + tests |
| 006–120 | Remaining companion implementations | 🚧 Planned / incremental |

The table reflects what is actually present in GitHub; it does not claim unfinished companion packages are already published.

## Validate all implemented packages

From the repository root:

```bash
bash scripts/list-companion-packages.sh
bash scripts/validate-companion-packages.sh
```

The repository CI runs the same validation for relevant pushes and pull requests.

## Read the complete series

[![Get the complete edition on Gumroad](../assets/gumroad-badge.svg)](https://ramsandesh.gumroad.com)

The commercial **Dart & Flutter Full Mastery — Complete 120-Part Master Edition** and available bundles are highlighted on the official Gumroad storefront:

### 🛒 **https://ramsandesh.gumroad.com**

Official repository: **https://github.com/sanskarIN/dart-flutter-master**

GitHub remains the home for open companion material; Gumroad is the purchase/support destination for the reader editions and bundles.
