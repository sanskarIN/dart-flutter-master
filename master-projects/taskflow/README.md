# TaskFlow — Productivity Master Project

[![Get the complete edition on Gumroad](../../assets/gumroad-badge.svg)](https://ramsandesh.gumroad.com)

TaskFlow is a credential-free Flutter productivity app that demonstrates clean state management, repository boundaries, filtering, prioritization, and deterministic tests.

## Architecture

- `TaskItem` immutable domain model
- `TaskRepository` abstraction
- `InMemoryTaskRepository` deterministic data source
- `TaskController` application state and commands
- Material UI with status filters and accessible controls

## Run checks

```bash
flutter pub get
flutter analyze
flutter test
```

This package intentionally omits generated platform runner folders. Add them locally with `flutter create .` if you want to launch it on a device.

## Learning goals

- Separate domain, data, state, and UI responsibilities.
- Keep filtering derived instead of duplicating state.
- Test task lifecycle behavior without databases or network services.
- Preserve deterministic IDs and timestamps in tests.

Official repository: **https://github.com/sanskarIN/dart-flutter-master**

Complete edition and bundles: **https://ramsandesh.gumroad.com**
