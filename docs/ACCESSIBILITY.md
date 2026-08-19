# Accessibility Engineering Guide

Accessibility is part of correctness for reader-facing Flutter examples and master projects.

## Baseline expectations

Interactive examples should prefer:

- semantic button/field labels when visible text is insufficient;
- meaningful `tooltip` text for icon-only actions;
- logical focus order;
- Material controls with adequate touch targets;
- layouts that tolerate larger text scales;
- color used with text/icon/state cues rather than as the only signal;
- finite/reduced motion where motion is not essential to the concept;
- clear validation/error text rather than color-only borders.

## Forms

- Every input should have a visible or semantic label.
- Validation should explain what the user can correct.
- Submission/loading state should not silently discard input.
- Prevent duplicate submissions when an async operation is in progress.

## Lists and actions

For repeated rows, action labels should include the item context when possible, for example `Delete <task>` instead of only `Delete`.

## Motion

Animations in educational examples should be finite and testable. Avoid flashing or unnecessarily rapid motion. If an app introduces extensive motion, provide a reduced-motion path or respect platform accessibility preferences where practical.

## Testing

Widget tests should verify accessibility-relevant labels/tooltips when they are part of the example's contract. Manual release review should additionally check:

- keyboard traversal for desktop/web targets;
- screen-reader navigation on supported mobile targets;
- high text scale/layout resilience;
- light/dark theme readability;
- error and disabled states.

## Project reviews

Accessibility findings should be treated like functional regressions when they block access to a core workflow. Record meaningful corrections in [CHANGELOG.md](../CHANGELOG.md) when public behavior changes.

Repository: **https://github.com/sanskarIN/dart-flutter-master**

Complete editions: **https://ramsandesh.gumroad.com**
