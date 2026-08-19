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


def is_flutter_manifest(text: str) -> bool:
    return bool(
        re.search(
            r"^\s{2}flutter:\s*\n\s{4}sdk:\s*flutter\s*$",
            text,
            re.MULTILINE,
        )
    )


def environment_sdk_constraint(text: str) -> str | None:
    lines = text.splitlines()
    for index, line in enumerate(lines):
        if line.strip() != "environment:" or line.startswith((" ", "\t")):
            continue
        for child in lines[index + 1 :]:
            if child and not child.startswith((" ", "\t")):
                break
            match = re.match(r"^\s{2}sdk:\s*['\"]?([^'\"\n]+)['\"]?\s*$", child)
            if match:
                return match.group(1).strip()
        break
    return None


def expected_package_kind(path: Path) -> str | None:
    """Return an enforced kind only where the repository has an explicit contract.

    Parts 001-010 are the implemented pure-Dart foundation set, Parts 011-020
    are the implemented Flutter set, and all current master projects are Flutter.
    Future Parts 021-120 are intentionally not pre-classified here; their actual
    manuscript topic and pubspec decide which validation pipeline owns them.
    """

    relative = path.relative_to(ROOT).as_posix()
    if relative.startswith("master-projects/"):
        return "flutter"

    match = re.match(r"parts/part-(\d{3})/pubspec\.yaml$", relative)
    if not match:
        return None

    part_number = int(match.group(1))
    if 1 <= part_number <= 10:
        return "dart"
    if 11 <= part_number <= 20:
        return "flutter"
    return None


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

    sdk_constraint = environment_sdk_constraint(text)
    if sdk_constraint is None:
        errors.append("missing environment SDK constraint")
    elif sdk_constraint.lower() == "any" or ">=" not in sdk_constraint:
        errors.append(f"SDK constraint is not bounded from below: {sdk_constraint!r}")

    if re.search(r":\s*any\s*$", text, re.MULTILINE):
        errors.append("dependency constraint 'any' is not allowed")

    flutter_manifest = is_flutter_manifest(text)
    expected_kind = expected_package_kind(path)
    if expected_kind == "flutter" and not flutter_manifest:
        errors.append("expected a Flutter SDK dependency for this package")
    if expected_kind == "dart" and flutter_manifest:
        errors.append("unexpected Flutter SDK dependency in a pure-Dart foundation package")

    package_dir = path.parent
    if not (package_dir / "README.md").is_file():
        errors.append("missing package README.md")

    tests = (
        list((package_dir / "test").glob("*_test.dart"))
        if (package_dir / "test").is_dir()
        else []
    )
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

    print(
        f"Verified {len(manifests)} package manifests with unique names, "
        "SDK constraints, READMEs, and tests."
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
