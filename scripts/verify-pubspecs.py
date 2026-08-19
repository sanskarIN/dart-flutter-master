#!/usr/bin/env python3
"""Validate companion/master-project pubspec and test structure without third-party packages."""

from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SEARCH_ROOTS = (ROOT / "parts", ROOT / "master-projects")
NAME_RE = re.compile(r"^[a-z][a-z0-9_]*$")
TOP_LEVEL_RE = re.compile(r"^(name|description|publish_to|version):\s*(.+?)\s*$", re.MULTILINE)
SDK_RE = re.compile(r"^\s{2}sdk:\s*['\"]?([^'\"\n]+)['\"]?\s*$", re.MULTILINE)


def is_flutter_manifest(text: str) -> bool:
    return bool(re.search(r"^\s{2}flutter:\s*\n\s{4}sdk:\s*flutter\s*$", text, re.MULTILINE))


def expected_flutter(path: Path) -> bool:
    relative = path.relative_to(ROOT).as_posix()
    if relative.startswith("master-projects/"):
        return True
    match = re.match(r"parts/part-(\d{3})/pubspec\.yaml$", relative)
    return bool(match and int(match.group(1)) >= 11)


def validate_manifest(path: Path) -> tuple[str | None, list[str]]:
    text = path.read_text(encoding="utf-8")
    fields = {key: value.strip(" '\"") for key, value in TOP_LEVEL_RE.findall(text)}
    errors: list[str] = []

    name = fields.get("name")
    if not name:
        errors.append("missing top-level name")
    elif not NAME_RE.fullmatch(name):
        errors.append(f"invalid package name: {name!r}")

    description = fields.get("description", "")
    if len(description.strip()) < 10:
        errors.append("missing or too-short description")

    if fields.get("publish_to") != "none":
        errors.append("publish_to must be none for repository-only educational packages")

    if not fields.get("version"):
        errors.append("missing version")

    sdk_match = SDK_RE.search(text)
    if not sdk_match:
        errors.append("missing environment SDK constraint")
    else:
        sdk_constraint = sdk_match.group(1).strip()
        if sdk_constraint.lower() == "any" or ">=" not in sdk_constraint:
            errors.append(f"SDK constraint is not bounded from below: {sdk_constraint!r}")

    if re.search(r":\s*any\s*$", text, re.MULTILINE):
        errors.append("dependency constraint 'any' is not allowed")

    flutter_manifest = is_flutter_manifest(text)
    if expected_flutter(path) and not flutter_manifest:
        errors.append("expected a Flutter SDK dependency for this package")
    if not expected_flutter(path) and flutter_manifest:
        errors.append("unexpected Flutter SDK dependency in a pure-Dart foundation package")

    package_dir = path.parent
    if not (package_dir / "README.md").is_file():
        errors.append("missing package README.md")

    tests = list((package_dir / "test").glob("*_test.dart")) if (package_dir / "test").is_dir() else []
    if not tests:
        errors.append("missing test/*_test.dart")

    return name, errors


def main() -> int:
    manifests: list[Path] = []
    for root in SEARCH_ROOTS:
        if root.is_dir():
            manifests.extend(root.glob("**/pubspec.yaml"))
    manifests.sort()

    if not manifests:
        print("No pubspec.yaml files found.", file=sys.stderr)
        return 1

    seen: dict[str, Path] = {}
    failures: list[str] = []

    for path in manifests:
        name, errors = validate_manifest(path)
        relative = path.relative_to(ROOT).as_posix()
        if name:
            previous = seen.get(name)
            if previous is not None:
                errors.append(
                    f"duplicate package name also used by {previous.relative_to(ROOT).as_posix()}"
                )
            else:
                seen[name] = path
        for error in errors:
            failures.append(f"{relative}: {error}")

    if failures:
        print("Pubspec/package verification failed:", file=sys.stderr)
        for failure in failures:
            print(f"- {failure}", file=sys.stderr)
        return 1

    print(f"Verified {len(manifests)} package manifests with unique names, SDK constraints, READMEs, and tests.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
