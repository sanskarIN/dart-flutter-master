# Contributing

Thank you for helping improve the Dart & Flutter Full Mastery companion repository.

## Good contribution types

- reproducible code fixes with regression tests;
- tests for examples and master projects;
- accessibility improvements;
- current-stable Dart/Flutter compatibility fixes;
- documentation clarifications;
- errata with exact part/section references;
- small, reviewable performance or reliability improvements;
- new companion examples that match the manuscript roadmap.

## Before starting

Read:

- [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md)
- [docs/COMPATIBILITY.md](docs/COMPATIBILITY.md)
- [docs/TESTING.md](docs/TESTING.md)
- [docs/DEPENDENCY_POLICY.md](docs/DEPENDENCY_POLICY.md)
- [docs/ACCESSIBILITY.md](docs/ACCESSIBILITY.md)
- [docs/PRIVACY.md](docs/PRIVACY.md)

For Flutter companion packages, also follow [docs/FLUTTER_COMPANION_GUIDE.md](docs/FLUTTER_COMPANION_GUIDE.md). For larger applications, follow [master-projects/PROJECT_STANDARD.md](master-projects/PROJECT_STANDARD.md).

## Before opening a pull request

1. Work from the latest `main` branch.
2. Keep the change focused on one problem or coherent feature.
3. Do not add secrets, credentials, copyrighted third-party assets, paid book files, or copied proprietary code.
4. Do not use `any` dependency constraints.
5. Add/update tests for behavior changes when practical.
6. Explain the affected part/project, expected behavior, test evidence, and platforms actually checked.
7. Do not claim a platform or workflow was tested if it was not executed.

## Validation

Run the repository-level checks:

```bash
bash scripts/verify-repository.sh
```

For pure Dart companion changes:

```bash
PACKAGE_KIND=dart REQUIRE_MATCH=1 bash scripts/validate-companion-packages.sh
```

For Flutter companion/master-project changes:

```bash
PACKAGE_KIND=flutter REQUIRE_MATCH=1 bash scripts/validate-companion-packages.sh
```

GitHub Actions reruns applicable checks on pull requests. A PR with known failing applicable checks is not release-ready.

## Commit identity

For local repository work, the project maintainer uses:

```bash
git config user.name "sanskarIN"
git config user.email "sanskarin@outlook.in"
```

Use descriptive commit messages. Signed-off-by trailers are encouraged for maintainer-generated commits and may be required by future repository policy.

## Security reports

Do not publish sensitive vulnerability details or credentials in a normal issue. Follow [SECURITY.md](SECURITY.md).

## Licensing

By contributing eligible companion source code, you agree that your contribution may be distributed under the repository's MIT License. The commercial book/publication rights boundary is documented in [BOOK_LICENSE.md](BOOK_LICENSE.md).

## Book and store

The commercial **Dart & Flutter Full Mastery** editions and official digital bundles are available on Gumroad:

**🛒 https://ramsandesh.gumroad.com**

Please do not copy paid book files into pull requests. Keep contributions focused on eligible public companion repository content.

Official repository: **https://github.com/sanskarIN/dart-flutter-master**
