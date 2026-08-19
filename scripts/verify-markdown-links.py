#!/usr/bin/env python3
"""Check repository-local Markdown links without making network requests."""

from __future__ import annotations

import re
import sys
from pathlib import Path
from urllib.parse import unquote

ROOT = Path(__file__).resolve().parent.parent
LINK_RE = re.compile(r"!?\[[^\]]*\]\(([^)]+)\)")
SKIP_PREFIXES = ("http://", "https://", "mailto:", "tel:", "data:", "#")


def destination(raw: str) -> str:
    raw = raw.strip()
    if raw.startswith("<") and ">" in raw:
        return raw[1 : raw.index(">")]
    return raw.split(maxsplit=1)[0]


def iter_links(path: Path):
    fenced = False
    marker = None
    for line_number, line in enumerate(path.read_text(encoding="utf-8").splitlines(), start=1):
        stripped = line.lstrip()
        if stripped.startswith("```") or stripped.startswith("~~~"):
            current = stripped[:3]
            if not fenced:
                fenced = True
                marker = current
            elif marker == current:
                fenced = False
                marker = None
            continue
        if fenced:
            continue
        for match in LINK_RE.finditer(line):
            yield line_number, destination(match.group(1))


def main() -> int:
    failures: list[str] = []
    checked = 0

    for markdown in sorted(ROOT.rglob("*.md")):
        if ".git" in markdown.parts or ".dart_tool" in markdown.parts or "build" in markdown.parts:
            continue
        for line_number, target in iter_links(markdown):
            if not target or target.startswith(SKIP_PREFIXES):
                continue
            target = unquote(target.split("#", 1)[0].split("?", 1)[0])
            if not target:
                continue
            resolved = (markdown.parent / target).resolve()
            checked += 1
            try:
                resolved.relative_to(ROOT)
            except ValueError:
                failures.append(
                    f"{markdown.relative_to(ROOT)}:{line_number}: link escapes repository: {target}"
                )
                continue
            if not resolved.exists():
                failures.append(
                    f"{markdown.relative_to(ROOT)}:{line_number}: missing local target: {target}"
                )

    if failures:
        print("Local Markdown link verification failed:", file=sys.stderr)
        for failure in failures:
            print(f"- {failure}", file=sys.stderr)
        return 1

    print(f"Verified {checked} repository-local Markdown link target(s).")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
