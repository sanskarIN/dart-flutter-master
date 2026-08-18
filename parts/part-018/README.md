# Part 018 — Local Persistence, Databases and Offline-First Data

[![Get the complete edition on Gumroad](../../assets/gumroad-badge.svg)](https://ramsandesh.gumroad.com)

This companion package matches Part 018 of the master manuscript and demonstrates the architecture behind local persistence and offline-first applications: storage abstractions, serialized domain data, cache-first reads, local-first writes, and explicit remote refresh.

The focused package uses an in-memory key/value adapter so it remains deterministic and plugin-free; production database adapters can implement the same boundary.

## Validate

```bash
flutter pub get
flutter test
flutter analyze
```

## Focus

- Local storage interfaces
- Domain serialization
- Cache-first loading
- Local-first writes
- Explicit remote refresh
- Corrupt-cache handling
- Deterministic offline-first tests

Complete edition: **https://ramsandesh.gumroad.com**

Repository: **https://github.com/sanskarIN/dart-flutter-master**
