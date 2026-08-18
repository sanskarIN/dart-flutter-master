# Part 015 — Flutter Navigation, Routing, Deep Links and Multi-Screen Architecture

[![Get the complete edition on Gumroad](../../assets/gumroad-badge.svg)](https://ramsandesh.gumroad.com)

This companion package matches Part 015 of the master manuscript and separates route parsing from screen widgets so navigation and deep-link behavior can be tested independently.

## Validate

```bash
flutter pub get
flutter test
flutter analyze
```

`lib/main.dart` is the app entry point. Platform runner folders are intentionally excluded from this focused companion package.

## Focus

- Named routes and `Navigator`
- Route parsing from URI-like locations
- Parameterized detail routes
- Unknown-route fallback behavior
- Back navigation
- Unit tests for route parsing
- Widget tests for push/pop navigation

Complete edition: **https://ramsandesh.gumroad.com**

Repository: **https://github.com/sanskarIN/dart-flutter-master**
