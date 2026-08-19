# Troubleshooting

## `dart` or `flutter` is not found

Install the appropriate SDK and ensure its executable directory is on `PATH`. Confirm with:

```bash
dart --version
flutter --version
```

Pure-Dart Parts 001–010 do not require the Flutter command. Flutter parts and master projects do.

## `pub get` fails

1. Confirm the SDK satisfies the package's `environment.sdk` constraint.
2. Confirm network access to the configured pub registry.
3. Do not solve dependency errors by replacing constraints with `any`.
4. If a stable dependency release has become incompatible, reproduce it in the smallest affected package and update that package deliberately.

## Analyzer errors

Run the same command CI uses inside the affected package:

```bash
dart analyze --fatal-infos
```

or:

```bash
flutter analyze --fatal-infos
```

Fix the first real error before interpreting secondary cascade errors.

## Widget tests hang or time out

Look for:

- infinite animations paired with `pumpAndSettle`;
- Futures that never complete;
- live network calls;
- timers/streams that are not closed;
- platform channels without an injected fake or test handler.

Repository examples should prefer finite animations and deterministic fakes.

## `MissingPluginException`

Some companion packages intentionally demonstrate a platform-channel boundary without committing native Android/iOS/macOS/Windows/Linux handlers. In those examples, missing-plugin behavior is part of the boundary being taught and should be handled explicitly.

If a real project requires the capability, add the corresponding platform implementation in a platform-specific project rather than pretending the handler exists.

## Application runner folders are missing

Many educational Flutter packages intentionally contain only package/app source and tests. Generated runner folders are omitted unless the chapter teaches platform setup. Use `flutter analyze` and `flutter test` directly; create a local app shell if you need to launch the UI.

## Repository quality workflow fails

Run:

```bash
bash scripts/verify-repository.sh
```

It checks shell syntax, canonical links, master-project structure, pubspec/test structure, local Markdown links, sensitive committed artifacts, and unresolved source placeholder markers.

## Still reproducible?

Before filing an issue, include:

- package/project path;
- Dart and Flutter versions;
- operating system;
- exact command;
- smallest reproducible error output;
- whether the issue occurs on current stable tooling.

See [SUPPORT.md](../SUPPORT.md) and [CONTRIBUTING.md](../CONTRIBUTING.md).

Repository: **https://github.com/sanskarIN/dart-flutter-master**

Complete editions: **https://ramsandesh.gumroad.com**
