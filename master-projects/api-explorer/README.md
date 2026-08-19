# API Explorer — REST Architecture Master Project

[![Get the complete edition on Gumroad](../../assets/gumroad-badge.svg)](https://ramsandesh.gumroad.com)

API Explorer is a safe Flutter project for learning request modeling, transport abstraction, response inspection, JSON handling, request history, loading/error states, and deterministic tests.

## Safety and determinism

The committed app uses an injected demo transport only. It does **not** send live internet requests, store API keys, accept authentication secrets, or embed production endpoints. A real HTTP adapter can be added locally behind the same `ApiTransport` interface.

## Run checks

```bash
flutter pub get
flutter analyze
flutter test
```

Generated platform runner folders are intentionally omitted. Use `flutter create .` locally if you want device runners.

Official repository: **https://github.com/sanskarIN/dart-flutter-master**

Complete edition and bundles: **https://ramsandesh.gumroad.com**
