# HabitPulse — Habit Tracking Master Project

[![Get the complete edition on Gumroad](../../assets/gumroad-badge.svg)](https://ramsandesh.gumroad.com)

HabitPulse is a local Flutter habit tracker focused on date-domain modeling, daily check-ins, streak calculations, completion summaries, and deterministic state tests.

## Architecture

- Immutable `Habit` model with normalized day keys
- Pure streak and completion calculations
- Repository abstraction for local persistence
- `HabitController` for add/check-in/delete flows
- Material UI with accessible daily actions
- Unit and widget tests

## Run checks

```bash
flutter pub get
flutter analyze
flutter test
```

Generated platform runner folders are intentionally omitted. Use `flutter create .` locally if you want device runners.

Official repository: **https://github.com/sanskarIN/dart-flutter-master**

Complete edition and bundles: **https://ramsandesh.gumroad.com**
