# Release Checklist

Use this checklist before each tagged companion-code release.

## Repository

- [ ] `README.md`, licenses, changelog, errata, security, and contribution docs are current.
- [ ] The official Gumroad link is current in reader-facing repository pages: `https://ramsandesh.gumroad.com`.
- [ ] No secrets, signing keys, credentials, paid book files, or unlicensed third-party assets are committed.
- [ ] Part/example paths are stable and documented.
- [ ] Version/tag matches the release notes.

## Dart / Flutter validation

- [ ] `dart format --output=none --set-exit-if-changed .` where applicable.
- [ ] `dart analyze` passes.
- [ ] `dart test` passes for Dart packages.
- [ ] `flutter analyze` passes for Flutter apps/packages.
- [ ] `flutter test` passes for Flutter apps/packages.
- [ ] Representative Android, web, desktop, and Apple-target instructions are rechecked on supported hosts where applicable.

## Release artifacts

- [ ] Archive paths are clean and deterministic.
- [ ] No production credentials are bundled.
- [ ] Checksums are generated.
- [ ] `CHANGELOG.md` is updated.
- [ ] `ERRATA.md` is reviewed.
- [ ] GitHub Release notes state compatibility and known limitations.

## Commercial-edition coordination

- [ ] Gumroad product files use the intended publication version.
- [ ] Gumroad product descriptions point to `https://github.com/sanskarIN/dart-flutter-master` for public code and errata.
- [ ] Store delivery is tested after replacing or adding files.
- [ ] Old bundles are not accidentally presented as the latest edition.

### 🛒 Gumroad

**https://ramsandesh.gumroad.com**
