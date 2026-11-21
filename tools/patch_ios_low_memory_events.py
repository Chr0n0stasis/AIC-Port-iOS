#!/usr/bin/env python3
"""Reduce duplicate city-defender animation resources in staged iOS data."""

from pathlib import Path
import sys


GENERIC_VISUAL_MAP = """IF $_casterid'>1' {
    IF $_casterid'<15' {
        _casterid=2
        IF $_i'>=4' {
            _casterid=4
        }
        IF $_i'>=8' {
            _casterid=5
        }
        IF $_i'>=12' {
            _casterid=6
        }
    }
}
CITYCASTER $_casterid _mv idle
"""


def patch_citycaster_visuals(raw_root: Path) -> None:
    path = raw_root / "evt" / "106" / "_put_citycaster.cmd"
    original = path.read_bytes()
    has_bom = original.startswith(b"\xef\xbb\xbf")
    newline = "\r\n" if b"\r\n" in original else "\n"
    text = original.decode("utf-8-sig").replace("\r\n", "\n")
    marker = "CITYCASTER $_casterid _mv idle"
    if text.count(marker) != 1:
        raise ValueError(f"Expected one citycaster command in {path}")
    replacement = GENERIC_VISUAL_MAP.rstrip("\n")
    encoded = text.replace(marker, replacement).replace("\n", newline).encode("utf-8")
    path.write_bytes((b"\xef\xbb\xbf" if has_bom else b"") + encoded)


def main() -> None:
    if len(sys.argv) != 2:
        raise SystemExit("usage: patch_ios_low_memory_events.py <Data/Raw>")
    patch_citycaster_visuals(Path(sys.argv[1]))


if __name__ == "__main__":
    main()
