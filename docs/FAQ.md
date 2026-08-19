# Frequently Asked Questions

## Is the book itself open source?

No. The public companion source code is MIT-licensed unless a file states otherwise. The book manuscript, compiled publication files, covers, diagrams, and publication artwork use the separate terms in [BOOK_LICENSE.md](../BOOK_LICENSE.md).

## Where do I get the complete reader editions?

The official storefront is **https://ramsandesh.gumroad.com**.

## Why are only some of the 120 parts implemented in GitHub?

The book series contains 120 parts, while the public companion-code implementation is being added incrementally. [parts/README.md](../parts/README.md) is the authoritative implementation matrix and does not mark unfinished parts as complete.

## Why do some Flutter packages have no Android/iOS/web runner folders?

Generated runners are intentionally omitted from many educational packages unless platform setup is itself part of the lesson. Analyze/test the package directly, or create a temporary local Flutter app shell to launch it.

## Which SDK version should I use?

Use current stable Dart/Flutter unless a package README says otherwise. See [COMPATIBILITY.md](COMPATIBILITY.md).

## How do I run all checks?

```bash
bash scripts/verify-repository.sh
PACKAGE_KIND=dart REQUIRE_MATCH=1 bash scripts/validate-companion-packages.sh
PACKAGE_KIND=flutter REQUIRE_MATCH=1 bash scripts/validate-companion-packages.sh
```

See [TESTING.md](TESTING.md) and [TROUBLESHOOTING.md](TROUBLESHOOTING.md).

## Can I use the companion code in my own project?

The repository source is MIT-licensed unless a file says otherwise. Preserve the license/copyright obligations described by the MIT License. Book/publication rights are separate.

## Where should I report an error in the book?

Use the book-correction/errata workflow described in [ERRATA.md](../ERRATA.md). Include the edition and exact part/section so the correction can be matched to the right publication version.

## Where should I report a security issue?

Follow [SECURITY.md](../SECURITY.md). Do not publish sensitive vulnerability details or credentials in a public issue.

## Does the repository collect user data?

The public companion repository is designed to work without collecting reader data. See [PRIVACY.md](PRIVACY.md).

## Is X/Twitter used as canonical project metadata?

No. The stable canonical project reference is the GitHub repository URL.

## Canonical links

Repository: **https://github.com/sanskarIN/dart-flutter-master**

Complete editions: **https://ramsandesh.gumroad.com**
