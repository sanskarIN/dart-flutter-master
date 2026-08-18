# Flutter Companion Package Standard

[![Get the complete edition on Gumroad](../assets/gumroad-badge.svg)](https://ramsandesh.gumroad.com)

This guide defines the repository standard for Flutter companion packages in **Dart & Flutter Full Mastery**.

## Canonical links

- **Repository:** https://github.com/sanskarIN/dart-flutter-master
- **Complete editions and bundles:** https://ramsandesh.gumroad.com
- **Reader/project contact:** sanskarin@outlook.in

## Recommended part structure

```text
parts/part-XYZ/
├── README.md
├── pubspec.yaml
├── lib/
│   ├── main.dart
│   ├── part_XYZ.dart
│   └── ...focused implementation files
└── test/
    └── ..._test.dart
```

A focused companion package does not need Android/iOS/web/desktop runner folders unless that part specifically teaches platform build or integration behavior. `lib/main.dart` may still provide the app entry point for use inside a generated Flutter shell.

## Package rules

1. Keep each part focused on the matching master-manuscript topic.
2. Prefer Flutter/Dart SDK APIs before adding external dependencies.
3. When an external package is educationally necessary, document why it is needed and keep its version constraint intentional.
4. Never commit secrets, signing files, production credentials, private endpoints, or real user data.
5. Keep paid book prose outside the public repository.
6. Put reusable logic outside large widget `build` methods when it improves testing and architecture.
7. Use stable public APIs and avoid relying on implementation details.

## UI and accessibility expectations

- Use semantic labels when visual meaning would otherwise be unclear.
- Do not encode meaning only through color.
- Keep interactive controls discoverable and keyboard/focus friendly where applicable.
- Make responsive behavior constraint-driven rather than device-name driven.
- Prefer theme-aware colors and typography over hard-coded presentation values.
- Give loading, empty, error, and success states explicit UI when the workflow needs them.

## Testing expectations

Every implemented Flutter companion should include tests appropriate to the chapter, such as:

- pure unit tests for parsers, validators, state objects, and transformations;
- widget tests for rendering, interaction, navigation, forms, semantics, and state transitions;
- deterministic fakes/injected callbacks instead of real production services;
- regression coverage for edge cases demonstrated by the part.

## Validation

From the repository root:

```bash
PACKAGE_KIND=flutter REQUIRE_MATCH=1 bash scripts/validate-companion-packages.sh
```

The Flutter GitHub Actions workflow installs the stable Flutter toolchain and runs package resolution, formatting parse checks, analysis, and tests for implemented Flutter companion packages.

## Platform-specific parts

When a chapter genuinely requires Android, iOS, macOS, Windows, Linux, or web scaffolding:

- keep platform code minimal and chapter-specific;
- document host/toolchain requirements;
- never commit signing secrets;
- separate platform adapters from shared application logic;
- test shared logic independently where possible.

## Commercial/public boundary

GitHub contains the open companion implementation, examples, tests, errata, and project scaffolds. The complete commercial reader editions and bundles are distributed through the official Gumroad storefront:

### **https://ramsandesh.gumroad.com**
