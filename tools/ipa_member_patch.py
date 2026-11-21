#!/usr/bin/env python3
"""Create and apply member-level patches between unsigned IPA archives."""

from __future__ import annotations

import argparse
import hashlib
import json
import shutil
import zipfile
from pathlib import Path


PATCH_FORMAT = "aic-ipa-member-patch-v1"
MANIFEST_NAME = "manifest.json"
PAYLOAD_PREFIX = "payload/"
CHUNK_SIZE = 4 * 1024 * 1024


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(CHUNK_SIZE), b""):
            digest.update(chunk)
    return digest.hexdigest()


def index_members(archive: zipfile.ZipFile) -> dict[str, zipfile.ZipInfo]:
    members: dict[str, zipfile.ZipInfo] = {}
    for info in archive.infolist():
        if info.filename in members:
            raise ValueError(f"Duplicate ZIP member is unsupported: {info.filename}")
        members[info.filename] = info
    return members


def member_metadata(info: zipfile.ZipInfo) -> dict:
    return {
        "name": info.filename,
        "date_time": list(info.date_time),
        "compress_type": info.compress_type,
        "external_attr": info.external_attr,
        "create_system": info.create_system,
        "size": info.file_size,
        "crc": info.CRC,
        "is_dir": info.is_dir(),
    }


def copy_member(source: zipfile.ZipFile, target: zipfile.ZipFile, name: str, info: zipfile.ZipInfo) -> None:
    if info.is_dir():
        target.writestr(info, b"")
        return
    with source.open(name, "r") as input_stream, target.open(info, "w", force_zip64=True) as output_stream:
        shutil.copyfileobj(input_stream, output_stream, CHUNK_SIZE)


def create_patch(base_path: Path, target_path: Path, patch_path: Path) -> None:
    with (
        zipfile.ZipFile(base_path, "r") as base,
        zipfile.ZipFile(target_path, "r") as target,
        zipfile.ZipFile(patch_path, "w", compression=zipfile.ZIP_DEFLATED, allowZip64=True) as patch,
    ):
        base_members = index_members(base)
        entries = []
        for index, target_info in enumerate(target.infolist()):
            base_info = base_members.get(target_info.filename)
            unchanged = (
                base_info is not None
                and base_info.CRC == target_info.CRC
                and base_info.file_size == target_info.file_size
                and base_info.is_dir() == target_info.is_dir()
            )
            entry = member_metadata(target_info)
            if unchanged:
                entry["source"] = "base"
            else:
                entry["source"] = "patch"
                if not target_info.is_dir():
                    payload_name = f"{PAYLOAD_PREFIX}{index:05d}"
                    entry["payload"] = payload_name
                    payload_info = zipfile.ZipInfo(payload_name, target_info.date_time)
                    payload_info.compress_type = zipfile.ZIP_DEFLATED
                    copy_member(target, patch, target_info.filename, payload_info)
            entries.append(entry)

        manifest = {
            "format": PATCH_FORMAT,
            "base": {
                "name": base_path.name,
                "sha256": sha256_file(base_path),
            },
            "target": {
                "name": target_path.name,
                "size": target_path.stat().st_size,
            },
            "entries": entries,
        }
        patch.writestr(MANIFEST_NAME, json.dumps(manifest, ensure_ascii=False, separators=(",", ":")))


def zip_info_from_entry(entry: dict) -> zipfile.ZipInfo:
    info = zipfile.ZipInfo(entry["name"], tuple(entry["date_time"]))
    info.compress_type = entry["compress_type"]
    info.external_attr = entry["external_attr"]
    info.create_system = entry["create_system"]
    return info


def apply_patch(base_path: Path, patch_path: Path, output_path: Path) -> None:
    temporary = output_path.with_suffix(output_path.suffix + ".partial")
    with (
        zipfile.ZipFile(base_path, "r") as base,
        zipfile.ZipFile(patch_path, "r") as patch,
    ):
        manifest = json.loads(patch.read(MANIFEST_NAME))
        if manifest.get("format") != PATCH_FORMAT:
            raise ValueError(f"Unsupported patch format: {manifest.get('format')!r}")
        actual_base_hash = sha256_file(base_path)
        if actual_base_hash != manifest["base"]["sha256"]:
            raise ValueError(
                f"Base IPA does not match patch manifest: expected {manifest['base']['sha256']}, "
                f"got {actual_base_hash}"
            )

        base_members = index_members(base)
        with zipfile.ZipFile(temporary, "w", allowZip64=True) as output:
            for entry in manifest["entries"]:
                info = zip_info_from_entry(entry)
                if entry["source"] == "base":
                    if entry["name"] not in base_members:
                        raise ValueError(f"Base IPA is missing {entry['name']}")
                    copy_member(base, output, entry["name"], info)
                elif entry["source"] == "patch":
                    if "payload" in entry:
                        copy_member(patch, output, entry["payload"], info)
                    else:
                        output.writestr(info, b"")
                else:
                    raise ValueError(f"Unknown entry source: {entry['source']}")

    with zipfile.ZipFile(temporary, "r") as output:
        output_members = index_members(output)
        for entry in manifest["entries"]:
            info = output_members.get(entry["name"])
            if info is None or info.file_size != entry["size"] or info.CRC != entry["crc"]:
                raise ValueError(f"Reassembled member failed verification: {entry['name']}")
    temporary.replace(output_path)


def main() -> None:
    parser = argparse.ArgumentParser()
    subparsers = parser.add_subparsers(dest="command", required=True)

    create = subparsers.add_parser("create")
    create.add_argument("--base", required=True, type=Path)
    create.add_argument("--target", required=True, type=Path)
    create.add_argument("--output", required=True, type=Path)

    apply = subparsers.add_parser("apply")
    apply.add_argument("--base", required=True, type=Path)
    apply.add_argument("--patch", required=True, type=Path)
    apply.add_argument("--output", required=True, type=Path)

    args = parser.parse_args()
    if args.command == "create":
        create_patch(args.base, args.target, args.output)
    else:
        apply_patch(args.base, args.patch, args.output)


if __name__ == "__main__":
    main()
