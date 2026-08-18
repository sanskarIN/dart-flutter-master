# Release Checklist

Use this checklist before each tagged companion-code release.

## Repository

- [ ] `README.md`, licenses, changelog, errata, security, and contribution docs are current.
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
