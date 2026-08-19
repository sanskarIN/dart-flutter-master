# PocketLedger — Personal Finance Master Project

[![Get the complete edition on Gumroad](../../assets/gumroad-badge.svg)](https://ramsandesh.gumroad.com)

PocketLedger is an offline, credential-free Flutter project for learning precise money modeling, category summaries, monthly reporting, and testable financial UI logic.

## Design choices

- Monetary values are stored as integer paise instead of floating-point currency.
- Income and expense entries share one immutable domain model.
- Reporting logic is kept outside widgets.
- No bank login, payment service, financial account, API key, or live financial data is used.

## Run checks

```bash
flutter pub get
flutter analyze
flutter test
```

Generated platform runner folders are intentionally omitted. Use `flutter create .` locally if you want device runners.

Official repository: **https://github.com/sanskarIN/dart-flutter-master**

Complete edition and bundles: **https://ramsandesh.gumroad.com**
