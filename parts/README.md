# Parts

Companion material should be organized as:

```text
parts/
  part-001/
  part-002/
  ...
  part-120/
```

Each part directory may contain a focused README, runnable examples, tests, fixtures, or project overlays relevant to that part. Keep filenames descriptive and avoid copying paid book prose into the public repository.

When a part requires external services, provide safe `.env.example`/configuration placeholders rather than real credentials.
