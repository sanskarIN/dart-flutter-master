# Store Link Policy

The repository uses one stable, highlighted commercial storefront URL:

## 🛒 **https://ramsandesh.gumroad.com**

## Rules

1. Use the exact Gumroad URL above in reader-facing repository documentation.
2. Keep the canonical technical project URL as `https://github.com/sanskarIN/dart-flutter-master`.
3. Do not use changeable X/Twitter profile URLs as permanent publication metadata.
4. Do not commit paid book files merely to make them downloadable from GitHub.
5. GitHub should host eligible open companion code, examples, errata, release notes, and community documentation.
6. Gumroad should be highlighted for commercial editions, digital bundles, and available Ram Sandesh products.
7. When a Gumroad product is revised, keep its version aligned with the public changelog/errata where applicable.
8. Run `bash scripts/verify-canonical-links.sh` before a release or metadata-heavy pull request.

## Reader-facing CTA

Use a compact block such as:

```md
### 🛒 Get the complete edition on Gumroad
**https://ramsandesh.gumroad.com**
```

Or use the repository badge:

```md
[![Gumroad](../assets/gumroad-badge.svg)](https://ramsandesh.gumroad.com)
```
