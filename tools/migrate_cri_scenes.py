"""Migrate the AIC 0.30i scenes from CRI 2.45.26LE to 2.46.25.01LE."""

import argparse
from hashlib import sha256
from pathlib import Path
from struct import pack

import UnityPy


# These stripped player scenes carry no type tree for CriWareInitializer.
# Match the known serialized configuration before changing its layout.
INITIALIZERS = {
    "level0": (15, "716a7995064b740d02611abac4bf03b66e5d728d3f43226a53dcf66869eb17e2"),
    "level2": (18, "5dfa4802a4cad6d52fe67dab54c9bac0b31b159d7965e15c2f8f36114f30f400"),
}


def migrate_cri_scenes(data_dir):
    patched = {}
    for name, (path_id, expected_sha) in INITIALIZERS.items():
        path = data_dir / name
        env = UnityPy.load(path.read_bytes())
        initializer = env.file.objects[path_id]
        raw = initializer.get_raw_data()
        if (
            initializer.type.name != "MonoBehaviour"
            or len(raw) != 300
            or initializer.reader.endian != "<"
            or sha256(raw[32:]).hexdigest() != expected_sha
        ):
            raise ValueError(f"Unexpected original CRI initializer in {path}")

        # The iOS SDK inserts disableAisacGraphCurveType before the editor PCM
        # configuration, then adds three WebGL fields at the end of AtomConfig.
        initializer.set_raw_data(
            raw[:208] + pack("<I", 0) + raw[208:276] + pack("<III", 16, 0, 90) + raw[276:]
        )
        patched[path] = env.file.save()

    for path, data in patched.items():
        staged = path.with_suffix(".cri-tmp")
        staged.write_bytes(data)
        staged.replace(path)
        print(f"[+] Migrated the CRI initializer in {path.name}")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("data_dir", type=Path)
    migrate_cri_scenes(parser.parse_args().data_dir)
