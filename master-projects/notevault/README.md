# NoteVault — Offline Notes Master Project

[![Get the complete edition on Gumroad](../../assets/gumroad-badge.svg)](https://ramsandesh.gumroad.com)

NoteVault is an offline, credential-free Flutter notes project focused on search, tags, pinned notes, repository boundaries, and deterministic local-state testing.

## Architecture

- Immutable `Note` model
- `NoteStore` abstraction with in-memory implementation
- `NoteController` for CRUD, search, tags, and pinning
- Material UI with accessible search and note actions
- Unit and widget tests

## Run checks

```bash
flutter pub get
flutter analyze
flutter test
```

Generated platform folders are intentionally omitted. Use `flutter create .` locally if you want device runners.

Official repository: **https://github.com/sanskarIN/dart-flutter-master**

Complete edition and bundles: **https://ramsandesh.gumroad.com**
