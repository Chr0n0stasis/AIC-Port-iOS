"""
Alice in Cradle (macOS -> iOS) Complete Asset Conversion Pipeline
- Transcodes desktop textures (DXT1, DXT5, DXT1Crunched, DXT5Crunched, BC7) to RGBA32
- Patches SerializedFile target_platform and _m_target_platform from StandaloneOSX (2) to iOS (9)
- Clears m_StreamData and strips orphaned .resS streams
- Repacks AssetBundles with LZ4 compression
- Updates RuntimeInitializeOnLoads.json and ScriptingAssemblies.json for AIC.iOS touch controls
"""

import os
import sys
import shutil
import time
import json
from concurrent.futures import ProcessPoolExecutor, as_completed
import UnityPy
from UnityPy.enums import BuildTarget, TextureFormat

UNSUPPORTED_FORMATS = {
    10: "DXT1",
    12: "DXT5",
    28: "DXT1Crunched",
    29: "DXT5Crunched",
    62: "BC7",
    63: "BC6H",
    64: "BC4",
    65: "BC5",
}

def convert_single_file(src_path, dst_path):
    """
    Process a single asset file (BundleFile or SerializedFile or plain data).
    Returns (status, num_textures_converted, file_size)
    """
    os.makedirs(os.path.dirname(dst_path), exist_ok=True)
    fname = os.path.basename(src_path)

    # Handle RuntimeInitializeOnLoads.json
    if fname == "RuntimeInitializeOnLoads.json":
        try:
            with open(src_path, "r", encoding="utf-8") as f:
                data = json.load(f)
            entry = {
                "assemblyName": "AIC.iOS",
                "nameSpace": "AIC.iOS",
                "className": "AICTouchOverlay",
                "methodName": "AutoInit",
                "loadTypes": 0,
                "isUnityClass": False
            }
            if entry not in data["root"]:
                data["root"].append(entry)
            with open(dst_path, "w", encoding="utf-8") as f:
                json.dump(data, f, indent=2)
            return ("json_patched", 0, os.path.getsize(dst_path))
        except Exception as e:
            shutil.copyfile(src_path, dst_path)
            return ("copied", 0, os.path.getsize(dst_path))

    # Handle ScriptingAssemblies.json
    if fname == "ScriptingAssemblies.json":
        try:
            with open(src_path, "r", encoding="utf-8") as f:
                data = json.load(f)
            if "AIC.iOS.dll" not in data["names"]:
                data["names"].append("AIC.iOS.dll")
                data["types"].append(16)
            with open(dst_path, "w", encoding="utf-8") as f:
                json.dump(data, f)
            return ("json_patched", 0, os.path.getsize(dst_path))
        except Exception as e:
            shutil.copyfile(src_path, dst_path)
            return ("copied", 0, os.path.getsize(dst_path))

    # Handle boot.config
    if fname == "boot.config":
        try:
            with open(src_path, "r", encoding="utf-8") as f:
                lines = [l.strip() for l in f if l.strip()]
            config = dict(l.split("=", 1) for l in lines if "=" in l)
            config["wait-for-native-debugger"] = "0"
            config["hdr-display-enabled"] = "0"
            config["player-connection-debug"] = "0"
            with open(dst_path, "w", encoding="utf-8") as f:
                for k, v in config.items():
                    f.write(f"{k}={v}\n")
            return ("boot_config_patched", 0, os.path.getsize(dst_path))
        except Exception:
            shutil.copyfile(src_path, dst_path)
            return ("copied", 0, os.path.getsize(dst_path))

    # Check if file is a Unity asset or bundle
    is_unity_candidate = (
        fname.endswith(".dat") or
        fname.endswith(".assets") or
        fname in ("globalgamemanagers", "level0", "level1", "level2", "level3")
    )

    if not is_unity_candidate:
        shutil.copyfile(src_path, dst_path)
        return ("copied", 0, os.path.getsize(dst_path))

    try:
        env = UnityPy.load(src_path)
    except Exception:
        shutil.copyfile(src_path, dst_path)
        return ("copied", 0, os.path.getsize(dst_path))

    if not env.files:
        shutil.copyfile(src_path, dst_path)
        return ("copied", 0, os.path.getsize(dst_path))

    needs_saving = False
    textures_converted = 0

    # 1. Update target_platform to 9 (iOS)
    from UnityPy.files.SerializedFile import SerializedFile
    from UnityPy.files.BundleFile import BundleFile

    for f in env.files.values():
        if isinstance(f, BundleFile):
            for inner in f.files.values():
                if isinstance(inner, SerializedFile):
                    inner.target_platform = BuildTarget.iOS
                    inner._m_target_platform = 9
                    needs_saving = True
        elif isinstance(f, SerializedFile):
            f.target_platform = BuildTarget.iOS
            f._m_target_platform = 9
            needs_saving = True

    # 2. Check and transcode unsupported textures
    for obj in env.objects:
        if obj.type.name == "Texture2D":
            try:
                data = obj.read()
                fmt = getattr(data, "m_TextureFormat", None)
                if fmt in UNSUPPORTED_FORMATS:
                    img = data.image
                    data.set_image(img, target_format=TextureFormat.RGBA32)
                    if hasattr(data, "m_StreamData"):
                        data.m_StreamData.offset = 0
                        data.m_StreamData.size = 0
                        data.m_StreamData.path = ""
                    data.save()
                    textures_converted += 1
                    needs_saving = True
            except Exception:
                pass

    # 3. For bundles, check if any remaining texture still references .resS
    if fname.endswith(".dat") and textures_converted > 0:
        has_remaining_streams = False
        for obj in env.objects:
            if obj.type.name == "Texture2D":
                try:
                    data = obj.read()
                    if hasattr(data, "m_StreamData") and data.m_StreamData.path:
                        has_remaining_streams = True
                        break
                except:
                    pass
        if not has_remaining_streams:
            for f in env.files.values():
                if hasattr(f, "files"):
                    orphaned = [k for k in f.files.keys() if k.endswith(".resS")]
                    for k in orphaned:
                        del f.files[k]

    if needs_saving:
        try:
            with open(dst_path, "wb") as f_out:
                if hasattr(env, "file") and env.file:
                    if fname.endswith(".dat"):
                        f_out.write(env.file.save(packer="lz4"))
                    else:
                        f_out.write(env.file.save())
                else:
                    for f in env.files.values():
                        f_out.write(f.save())
            return ("converted", textures_converted, os.path.getsize(dst_path))
        except Exception as save_err:
            shutil.copyfile(src_path, dst_path)
            return ("failed_save_copied", 0, os.path.getsize(dst_path))
    else:
        shutil.copyfile(src_path, dst_path)
        return ("untouched_copied", 0, os.path.getsize(dst_path))


def process_file_task(args):
    src, dst = args
    return convert_single_file(src, dst)


def convert_directory(src_dir, dst_dir, max_workers=8):
    print("=" * 65)
    print("  Alice in Cradle macOS -> iOS Asset Conversion Pipeline  ")
    print("=" * 65)
    print(f"[*] Source directory: {src_dir}")
    print(f"[*] Target directory: {dst_dir}")
    tasks = []
    total_src_size = 0

    for root, dirs, files in os.walk(src_dir):
        # Skip Managed folder (handled by AssemblyPatcher)
        if "Managed" in dirs:
            dirs.remove("Managed")
        for f in files:
            src_file = os.path.join(root, f)
            rel_path = os.path.relpath(src_file, src_dir)
            dst_file = os.path.join(dst_dir, rel_path)
            tasks.append((src_file, dst_file))
            total_src_size += os.path.getsize(src_file)

    print(f"[*] Found {len(tasks)} files total ({total_src_size / (1024*1024):.2f} MB).")
    print(f"[*] Converting with {max_workers} parallel workers...")

    start_time = time.time()
    converted_files = 0
    total_textures = 0
    copied_files = 0

    with ProcessPoolExecutor(max_workers=max_workers) as executor:
        futures = {executor.submit(process_file_task, t): t for t in tasks}
        completed = 0
        for future in as_completed(futures):
            completed += 1
            src, dst = futures[future]
            fname = os.path.basename(src)
            try:
                status, tex_count, sz = future.result()
                if status == "converted":
                    converted_files += 1
                    total_textures += tex_count
                else:
                    copied_files += 1
                if completed % 50 == 0 or completed == len(tasks):
                    pct = (completed / len(tasks)) * 100
                    elapsed = time.time() - start_time
                    print(f"[{completed:4d}/{len(tasks)}] ({pct:5.1f}%) Modified: {converted_files} | Transcoded: {total_textures} tex | Copied: {copied_files} | Elapsed: {elapsed:.1f}s")
            except Exception as e:
                print(f"[!] Error processing {fname}: {e}")

    total_time = time.time() - start_time
    total_dst_size = sum(os.path.getsize(dst) for _, dst in tasks if os.path.exists(dst))

    print("=" * 65)
    print(f"[+] Asset Conversion Complete in {total_time:.2f} seconds!")
    print(f"    Total files processed:    {len(tasks)}")
    print(f"    Files modified/updated:  {converted_files}")
    print(f"    Textures transcoded:     {total_textures}")
    print(f"    Directly copied files:   {copied_files}")
    print(f"    Output data total size:  {total_dst_size / (1024*1024):.2f} MB")
    print("=" * 65)


if __name__ == "__main__":
    default_src = r"d:\Users\Chr0n0s\Documents\Gits\OAfV727f_aic_installer_030i\Alice in Cradle\Alice in Cradle.app\Contents\Resources\Data"
    default_dst = r"d:\Users\Chr0n0s\Documents\Gits\AIC-Port-iOS\ConvertedData"

    src = sys.argv[1] if len(sys.argv) > 1 else default_src
    dst = sys.argv[2] if len(sys.argv) > 2 else default_dst

    convert_directory(src, dst)
