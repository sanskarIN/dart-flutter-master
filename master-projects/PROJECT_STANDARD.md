# Master Project Standard

[![Gumroad](../assets/gumroad-badge.svg)](https://ramsandesh.gumroad.com)

Use this standard for every new project under `master-projects/`.

## Required package shape

```text
master-projects/<project-name>/
├── README.md
├── pubspec.yaml
├── lib/
│   ├── main.dart
│   └── ...domain/data/state/ui files
└── test/
    └── ..._test.dart
```

Platform runner directories are optional and should not be committed unless the project teaches platform-specific setup.

## Architecture rules

1. Keep domain models independent of widgets where practical.
2. Put persistence/network/platform access behind interfaces.
3. Inject clocks, IDs, transports, repositories, or services when determinism matters.
4. Keep secrets, account credentials, production tokens, and private endpoints out of source control.
5. Prefer immutable state/domain values and derived data over duplicated mutable fields.
6. Make failure states visible and testable.
7. Add semantic labels/tooltips for non-obvious interactive controls.

## Testing baseline

Every project should cover at least:

- one domain/business-rule test
- one state/controller/repository test
- one invalid/error-path test where relevant
- one Flutter widget test

Run:

```bash
flutter pub get
flutter analyze
flutter test
```

Repository-wide validation:

```bash
PACKAGE_KIND=flutter REQUIRE_MATCH=1 bash scripts/validate-companion-packages.sh
```

## Documentation baseline

Every project README must include:

- project purpose
- architecture summary
- run/test commands
- safety/privacy or credential notes where relevant
- official repository URL
- official Gumroad URL

Official repository: **https://github.com/sanskarIN/dart-flutter-master**

Complete editions and bundles: **https://ramsandesh.gumroad.com**
