# Privacy and Data Handling

The public companion repository is designed to work without collecting reader data.

## Repository policy

Public examples and tests must not commit or require:

- real API keys, tokens, passwords, private certificates, or signing keys;
- production user data;
- personal contact lists, messages, location histories, financial-account data, or private documents;
- analytics identifiers tied to real users;
- copied production databases or logs.

Use deterministic sample data and in-memory/fake adapters by default.

## Local persistence examples

Projects such as NoteVault, PocketLedger, HabitPulse, and offline-first learning parts demonstrate storage boundaries. The in-repository implementations are educational and use sample/in-memory behavior unless a project explicitly documents another local store.

Do not interpret an educational local-store abstraction as a guarantee that a particular storage backend is encrypted or appropriate for sensitive production data.

## Network examples

Networking examples should inject transports/services and use deterministic fakes in tests. Live service credentials must be supplied locally through an appropriate secret/configuration mechanism and must never be committed.

## Logging

Production adaptations should avoid logging secrets or sensitive payloads. Prefer structured, minimal error context and redact identifiers when full values are unnecessary for diagnosis.

## Platform permissions

If a future project requires camera, microphone, location, contacts, storage, notifications, or similar OS permissions:

1. request only the capability required for the feature;
2. explain why it is needed before or when the OS prompt appears;
3. handle denial gracefully;
4. document retention and deletion behavior;
5. avoid background collection unrelated to the visible feature.

## Security boundary

Potential vulnerabilities should be reported using [SECURITY.md](../SECURITY.md), not in public issues when disclosure could expose users or credentials.

## Canonical links

Repository: **https://github.com/sanskarIN/dart-flutter-master**

Complete editions: **https://ramsandesh.gumroad.com**
