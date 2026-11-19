"""Inventory build-time and runtime dependencies in Unity managed assemblies."""

import argparse
import json
from collections import Counter, defaultdict
from pathlib import Path

import dnfile
from dncil.cil.body import CilMethodBody
from dncil.cil.body.reader import CilMethodBodyReaderBytes
from dncil.cil.error import MethodBodyFormatError


TOKEN_TABLES = {6: "MethodDef", 10: "MemberRef", 43: "MethodSpec"}
CALLS = {"call", "callvirt", "newobj", "jmp", "ldftn", "ldvirtftn"}
RUNTIME_LOAD = {"Load", "LoadFrom", "LoadFile", "UnsafeLoadFrom", "LoadModule"}
REFLECTION_TYPES = {"System.Type", "System.Reflection.Assembly", "System.Activator"}
STARTUP_APIS = {"MonoPInvokeCallbackAttribute", "RuntimeInitializeOnLoadMethodAttribute"}


def type_name(row):
    if row is None:
        return ""
    if hasattr(row, "TypeName"):
        return ".".join(part for part in (str(row.TypeNamespace), str(row.TypeName)) if part)
    return ""


def short_type(row, tables):
    name = type_name(row)
    if name or not hasattr(row, "Signature"):
        return name
    # A MemberRef to a constructed generic type names a TypeSpec with GENERICINST.
    sig = row.Signature.value
    if len(sig) < 3 or sig[0] != 0x15 or sig[1] not in (0x11, 0x12):
        return ""
    first = sig[2]
    if first & 0x80 == 0:
        index = first
    elif first & 0xC0 == 0x80 and len(sig) >= 4:
        index = ((first & 0x3F) << 8) | sig[3]
    elif first & 0xE0 == 0xC0 and len(sig) >= 6:
        index = int.from_bytes(sig[2:6], "big") & 0x1FFFFFFF
    else:
        return ""
    tag, row_id = index & 3, index >> 2
    if tag not in (0, 1) or row_id == 0:
        return ""
    return type_name(getattr(tables, ("TypeDef", "TypeRef")[tag]).rows[row_id - 1])


def method_name(table, index, tables, owners):
    if index < 1 or table not in TOKEN_TABLES.values():
        return "", ""
    if table == "MethodDef":
        return owners[index]
    row = getattr(tables, table).rows[index - 1]
    if table == "MethodSpec":
        method = row.Method
        return method_name(method.table.name, method.row_index, tables, owners)
    return short_type(row.Class.row, tables), str(row.Name)


def review_category(owner, method):
    if owner.startswith("System.Reflection.Emit.") or (
        owner == "System.AppDomain" and method == "DefineDynamicAssembly"
    ):
        return "runtime_emit"
    if owner in ("System.Reflection.Assembly", "System.AppDomain") and method in RUNTIME_LOAD:
        return "assembly_load_review"
    if owner.startswith("System.Linq.Expressions.") and method in ("Compile", "CompileToMethod"):
        return "expression_compile_review"
    if method in ("MakeGenericMethod", "MakeGenericType") and owner.startswith(("System.Type", "System.Reflection.")):
        return "reflection_generic_review"
    if owner in REFLECTION_TYPES and method in ("GetType", "CreateInstance"):
        return "reflection_stripping_review"
    if owner == "System.Diagnostics.Process" and method == "Start":
        return "desktop_process_review"
    if owner == "System.Runtime.InteropServices.Marshal" and method in (
        "GetDelegateForFunctionPointer", "GetFunctionPointerForDelegate",
    ):
        return "interop_callback_review"
    return None


def inspect_assembly(path):
    data = path.read_bytes()
    pe = dnfile.dnPE(data=data, fast_load=True)
    try:
        pe.parse_data_directories(directories=[14])
        if not pe.net or not pe.net.mdtables or not pe.net.mdtables.Assembly:
            raise ValueError("Expected a managed assembly")
        tables = pe.net.mdtables
        methods = list(tables.MethodDef or [])
        owners = {
            entry.row_index: (type_name(defined), str(entry.row.Name))
            for defined in tables.TypeDef for entry in defined.MethodList
        }
        imports = {}
        for pinvoke in tables.ImplMap or []:
            target = pinvoke.MemberForwarded
            if target.table.name == "MethodDef":
                imports[target.row_index] = (
                    str(pinvoke.ImportScope.row.Name), str(pinvoke.ImportName)
                )
        callbacks = defaultdict(list)
        for attribute in tables.CustomAttribute or []:
            parent = attribute.Parent
            constructor = attribute.Type
            if parent.table.name != "MethodDef":
                continue
            owner, _ = method_name(constructor.table.name, constructor.row_index, tables, owners)
            name = owner.rsplit(".", 1)[-1]
            if name in STARTUP_APIS:
                callbacks[name].append("::".join(owners[parent.row_index]))
        findings = defaultdict(set)
        errors = {}
        body_count = 0
        reader = CilMethodBodyReaderBytes(data)
        for index, method in enumerate(methods, 1):
            if not method.Rva or not method.ImplFlags.miIL:
                continue
            caller = "::".join(owners[index])
            try:
                reader.seek(pe.get_offset_from_rva(method.Rva))
                body = CilMethodBody(reader)
            except (MethodBodyFormatError, ValueError) as error:
                errors[f"{index}:{caller}"] = str(error)
                continue
            body_count += 1
            for inst in body.instructions:
                if inst.mnemonic == "calli":
                    findings["indirect_call_review"].add((caller, "calli"))
                    continue
                if inst.mnemonic not in CALLS:
                    continue
                token = inst.operand
                table = TOKEN_TABLES.get(getattr(token, "table", None))
                if not table:
                    continue
                owner, name = method_name(table, token.rid, tables, owners)
                category = review_category(owner, name)
                if category:
                    findings[category].add((caller, f"{owner}::{name}"))
                if table == "MethodDef" and token.rid in imports:
                    library, entry = imports[token.rid]
                    findings["native_import_call"].add((caller, f"{library}::{entry}"))
        return {
            "assembly": str(tables.Assembly.rows[0].Name),
            "references": sorted(str(row.Name) for row in tables.AssemblyRef or []),
            "il_bodies_parsed": body_count,
            "native_imports": dict(sorted(Counter(library for library, _ in imports.values()).items())),
            "method_attributes": {name: sorted(items) for name, items in callbacks.items()},
            "findings": {kind: sorted(items) for kind, items in sorted(findings.items())},
            "method_parse_errors": errors,
        }
    finally:
        pe.close()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("managed", type=Path)
    parser.add_argument("patterns", nargs="*", default=["*.dll"], help="Assembly names or glob patterns")
    args = parser.parse_args()
    paths = sorted({path for pattern in args.patterns for path in args.managed.glob(pattern) if path.is_file()})
    if not paths:
        parser.error(f"No assemblies matched in {args.managed}")
    result = {"assemblies": {}, "assembly_parse_errors": {}}
    for path in paths:
        try:
            result["assemblies"][path.name] = inspect_assembly(path)
        except (OSError, dnfile.PEFormatError, ValueError, AttributeError, IndexError, KeyError) as error:
            result["assembly_parse_errors"][path.name] = f"{type(error).__name__}: {error}"
    print(json.dumps(result, indent=2, ensure_ascii=True))
    return int(bool(result["assembly_parse_errors"]) or any(
        row["method_parse_errors"] for row in result["assemblies"].values()
    ))


if __name__ == "__main__":
    raise SystemExit(main())
