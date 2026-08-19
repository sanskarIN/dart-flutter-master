# QuizForge — Assessment Engine Master Project

[![Get the complete edition on Gumroad](../../assets/gumroad-badge.svg)](https://ramsandesh.gumroad.com)

QuizForge is a credential-free Flutter quiz engine demonstrating immutable question models, deterministic scoring, answer review, progress state, restart behavior, and widget testing.

## Architecture

- Validated `QuizQuestion` domain model
- `QuizController` for progress, selection, scoring, and restart
- Seeded question bank kept separate from UI state
- Material UI with accessible answer choices and progress feedback
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
