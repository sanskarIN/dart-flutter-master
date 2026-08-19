# Compatibility and Support Matrix

## Toolchain policy

The repository CI validates against the current stable Dart/Flutter channels configured in GitHub Actions. Individual `pubspec.yaml` files also declare their minimum Dart SDK constraints.

The repository does not promise that every historical Dart or Flutter release will continue to run every example. Educational code is maintained toward current stable tooling while avoiding unnecessary use of unstable APIs.

## Package groups

| Area | Runtime/toolchain | Validation |
|---|---|---|
| Parts 001–010 | Dart SDK | `dart pub get`, format parse, `dart analyze --fatal-infos`, tests |
| Parts 011–120 when implemented | Flutter stable | `flutter pub get`, Dart format parse, `flutter analyze --fatal-infos`, widget/unit tests |
| `master-projects/*` | Flutter stable | structure verification plus the Flutter validation pipeline |
| Repository scripts/docs | Bash + Python 3 | repository-quality workflow |

## Platform policy

Most committed Flutter companions deliberately omit generated Android/iOS/web/desktop runner folders unless a chapter specifically teaches platform integration. This keeps the repository small and avoids treating generated scaffolding as educational source.

When a package contains only `lib/`, `test/`, and `pubspec.yaml`, validate it with `flutter analyze` and `flutter test`. To run it as an application, create a temporary Flutter shell locally and integrate the package source as described in that package README.

Platform-specific projects must document their supported targets explicitly. A platform is not considered supported merely because Flutter can theoretically build for it.

## Breaking changes

If a stable Dart/Flutter release deprecates or removes an API used here:

1. reproduce the failure on current stable tooling;
2. update the smallest affected example;
3. preserve the educational concept rather than the obsolete API;
4. add an entry to [CHANGELOG.md](../CHANGELOG.md) or [ERRATA.md](../ERRATA.md) when reader-facing behavior changes;
5. run the full validation workflows before merging.

## Canonical links

Repository: **https://github.com/sanskarIN/dart-flutter-master**

Complete editions: **https://ramsandesh.gumroad.com**
