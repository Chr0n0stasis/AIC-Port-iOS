#!/usr/bin/env python3
"""
Generate UnityICallRegistration.cpp by inspecting libiPhone-lib.a for all
defined internal call (icall) registration symbols (_Register_*).
"""

import os
import sys
import subprocess
import re
import argparse

def main():
    parser = argparse.ArgumentParser(description="Generate Unity icall registration source from libiPhone-lib.a")
    parser.add_argument("--lib", required=True, help="Path to libiPhone-lib.a")
    parser.add_argument("--out", required=True, help="Output path for UnityICallRegistration.cpp")
    parser.add_argument("--verbose", action="store_true", help="Print debug information")
    args = parser.parse_args()

    lib_path = os.path.abspath(args.lib)
    out_path = os.path.abspath(args.out)

    if not os.path.isfile(lib_path):
        print(f"::error::libiPhone-lib.a not found at: {lib_path}", file=sys.stderr)
        sys.exit(1)

    # Find nm binary (using xcrun if available)
    nm_bin = "nm"
    try:
        res = subprocess.run(["xcrun", "--find", "nm"], capture_output=True, text=True, check=True)
        found = res.stdout.strip()
        if found and os.path.exists(found):
            nm_bin = found
    except Exception:
        pass

    # Try nm with -arch arm64 first
    raw_output = ""
    for cmd_args in [
        [nm_bin, "-arch", "arm64", "-gU", lib_path],
        [nm_bin, "-gU", lib_path],
        [nm_bin, "-arch", "arm64", "-g", lib_path],
        [nm_bin, "-g", lib_path]
    ]:
        if args.verbose:
            print(f"[*] Trying: {' '.join(cmd_args)}")
        proc = subprocess.run(cmd_args, capture_output=True, text=True)
        if proc.returncode == 0 and len(proc.stdout) > 0:
            raw_output = proc.stdout
            if args.verbose:
                print(f"[+] Succeeded with: {' '.join(cmd_args)}")
            break

    if not raw_output:
        print(f"::error::Failed to extract symbols from {lib_path} using {nm_bin}", file=sys.stderr)
        sys.exit(1)

    symbols = set()
    for line in raw_output.splitlines():
        parts = line.strip().split()
        if len(parts) >= 2 and parts[-2] in ("T", "t"):
            sym = parts[-1]
            if sym.startswith("_Register_") and re.match(r"^_Register_[A-Za-z0-9_]+$", sym):
                func_name = sym[1:]
                symbols.add(func_name)

    sorted_funcs = sorted(list(symbols))
    print(f"[+] Found {len(sorted_funcs)} internal call registration symbols in {os.path.basename(lib_path)}")

    if len(sorted_funcs) == 0:
        print("::warning::No _Register_ symbols matched! Internal call dispatch may be incomplete.")

    chunk_size = 200
    num_chunks = (len(sorted_funcs) + chunk_size - 1) // chunk_size if sorted_funcs else 1

    lines = []
    lines.append("// ============================================================================")
    lines.append("// Auto-generated Unity Internal Call (icall) Registration for iOS IL2CPP")
    lines.append(f"// Generated from: {os.path.basename(lib_path)}")
    lines.append(f"// Total icall registration functions: {len(sorted_funcs)}")
    lines.append("// ============================================================================\n")
    lines.append("#include <stddef.h>\n")

    lines.append('extern "C" {')
    for func in sorted_funcs:
        lines.append(f"    void {func}();")
    lines.append("}\n")

    for chunk_idx in range(num_chunks):
        chunk_funcs = sorted_funcs[chunk_idx * chunk_size : (chunk_idx + 1) * chunk_size]
        lines.append(f"static void RegisterInternalCalls_Chunk_{chunk_idx}()\n{{")
        for func in chunk_funcs:
            lines.append(f"    {func}();")
        lines.append("}\n")

    # void RegisterAllStrippedInternalCalls() must have C++ linkage to match __Z32RegisterAllStrippedInternalCallsv
    lines.append("void RegisterAllStrippedInternalCalls()\n{")
    for chunk_idx in range(num_chunks):
        lines.append(f"    RegisterInternalCalls_Chunk_{chunk_idx}();")
    lines.append("}\n")

    os.makedirs(os.path.dirname(out_path), exist_ok=True)
    with open(out_path, "w", encoding="utf-8") as f:
        f.write("\n".join(lines))

    print(f"[+] Generated {out_path} ({os.path.getsize(out_path)} bytes, {num_chunks} chunks)")

if __name__ == "__main__":
    main()
