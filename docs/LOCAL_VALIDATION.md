# Local Validation

The publication-generation environment used to assemble the book does not provide the complete Dart/Flutter SDK toolchain. Run the following on a development machine before the first public companion-code release.

## Identity

```bash
git config user.name "sanskarIN"
git config user.email "sanskarin@outlook.in"
```

## Toolchain

```bash
flutter --version
dart --version
flutter doctor -v
```

## Dart packages

```bash
dart pub get
dart format --output=none --set-exit-if-changed .
dart analyze
dart test
```

## Flutter packages/apps

```bash
flutter pub get
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
```

Build only the targets supported by the current host and project. Record any platform-specific prerequisites in the relevant part/project README rather than hiding failures or disabling analysis rules without explanation.

## Reader resources

- Official companion repository: **https://github.com/sanskarIN/dart-flutter-master**
- Complete editions and bundles on Gumroad: **https://ramsandesh.gumroad.com**
