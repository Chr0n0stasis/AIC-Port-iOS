#!/usr/bin/env python3
"""Apply small low-memory event limits after private game data is staged."""

from pathlib import Path
import sys


def replace_once(text: str, old: str, new: str, filename: Path) -> str:
    count = text.count(old)
    if count != 1:
        raise ValueError(f"Expected one occurrence in {filename}: {old!r} (found {count})")
    return text.replace(old, new, 1)


def patch_citycaster_squad(raw_root: Path) -> None:
    path = raw_root / "evt" / "106" / "_put_citycaster.cmd"
    original = path.read_bytes()
    has_bom = original.startswith(b"\xef\xbb\xbf")
    newline = "\r\n" if b"\r\n" in original else "\n"
    text = original.decode("utf-8-sig").replace("\r\n", "\n")

    # Fifteen defenders cost over 600 MiB during the Georgia defense. Eight
    # retain the event composition while leaving enough room for the boss.
    text = replace_once(text, "IF $_i'==14' {", "IF $_i'==7' {", path)
    text = replace_once(text, "IF $_i'<15' {", "IF $_i'<8' {", path)

    encoded = text.replace("\n", newline).encode("utf-8")
    path.write_bytes((b"\xef\xbb\xbf" if has_bom else b"") + encoded)


def main() -> None:
    if len(sys.argv) != 2:
        raise SystemExit("usage: patch_ios_low_memory_events.py <Data/Raw>")
    patch_citycaster_squad(Path(sys.argv[1]))


if __name__ == "__main__":
    main()
