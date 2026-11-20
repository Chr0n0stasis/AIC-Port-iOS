using System;
using System.IO;
using System.Linq;
using Mono.Cecil;
using Mono.Cecil.Cil;

class Program
{
    static int Main(string[] args)
    {
        if (args is ["--ios-startup", var managedDir])
        {
            IosStartupPatcher.PatchInputSystem(managedDir);
            return 0;
        }

        string defaultSrc = @"d:\Users\Chr0n0s\Documents\Gits\OAfV727f_aic_installer_030i\Alice in Cradle\Alice in Cradle.app\Contents\Resources\Data\Managed";
        string defaultDst = @"d:\Users\Chr0n0s\Documents\Gits\AIC-Port-iOS\PatchedManaged";

        string srcDir = args.Length > 0 ? args[0] : defaultSrc;
        string dstDir = args.Length > 1 ? args[1] : defaultDst;

        Console.WriteLine("==================================================");
        Console.WriteLine("  Alice in Cradle (iOS Port) Assembly Patcher    ");
        Console.WriteLine("==================================================");

        Directory.CreateDirectory(dstDir);

        // 1. Copy all DLLs first (if src != dst)
        if (Path.GetFullPath(srcDir) != Path.GetFullPath(dstDir))
        {
            Console.WriteLine("[*] Copying all managed assemblies to output folder...");
            foreach (var file in Directory.GetFiles(srcDir, "*.dll"))
            {
                string dest = Path.Combine(dstDir, Path.GetFileName(file));
                File.Copy(file, dest, true);
            }
        }

        // 1b. Patch mscorlib.dll for IL2CPP enum sharing types FIRST before resolving anything
        string mscorlibPath = Path.Combine(dstDir, "mscorlib.dll");
        if (File.Exists(mscorlibPath))
        {
            Console.WriteLine("[*] Checking mscorlib.dll for IL2CPP enum sharing types...");
            var corlibParams = new ReaderParameters { InMemory = true };
            using (var asm = AssemblyDefinition.ReadAssembly(mscorlibPath, corlibParams))
            {
                var mod = asm.MainModule;
                var enumBase = mod.Types.FirstOrDefault(t => t.FullName == "System.Enum");
                if (enumBase != null)
                {
                    var enumSpecs = new (string Name, TypeReference Underlying)[]
                    {
                        ("SByteEnum", mod.TypeSystem.SByte),
                        ("Int16Enum", mod.TypeSystem.Int16),
                        ("Int32Enum", mod.TypeSystem.Int32),
                        ("Int64Enum", mod.TypeSystem.Int64),
                        ("ByteEnum", mod.TypeSystem.Byte),
                        ("UInt16Enum", mod.TypeSystem.UInt16),
                        ("UInt32Enum", mod.TypeSystem.UInt32),
                        ("UInt64Enum", mod.TypeSystem.UInt64),
                    };

                    bool modified = false;
                    foreach (var (name, underlying) in enumSpecs)
                    {
                        if (!mod.Types.Any(t => t.FullName == $"System.{name}"))
                        {
                            var enumType = new TypeDefinition(
                                "System",
                                name,
                                TypeAttributes.Public | TypeAttributes.Sealed | TypeAttributes.AnsiClass | TypeAttributes.AutoClass,
                                enumBase
                            );
                            var valField = new FieldDefinition(
                                "value__",
                                FieldAttributes.Public | FieldAttributes.SpecialName | FieldAttributes.RTSpecialName,
                                underlying
                            );
                            enumType.Fields.Add(valField);
                            mod.Types.Add(enumType);
                            Console.WriteLine($"  -> Injected System.{name} (underlying: {underlying.Name})");
                            modified = true;
                        }
                    }

                    if (modified)
                    {
                        Console.WriteLine("  [+] mscorlib.dll injected with IL2CPP shared enum types.");
                    }

                    // 1c. Fix System.Array generic icalls for IL2CPP
                    var arrayType = mod.Types.FirstOrDefault(t => t.FullName == "System.Array");
                    if (arrayType != null)
                    {
                        var getValueMethod = arrayType.Methods.FirstOrDefault(m => m.Name == "GetValue" && m.Parameters.Count == 1 && m.Parameters[0].ParameterType.FullName == "System.Int32");
                        var setValueMethod = arrayType.Methods.FirstOrDefault(m => m.Name == "SetValue" && m.Parameters.Count == 2 && m.Parameters[0].ParameterType.FullName == "System.Object" && m.Parameters[1].ParameterType.FullName == "System.Int32");

                        var getGenericImpl = arrayType.Methods.FirstOrDefault(m => m.Name == "GetGenericValueImpl");
                        if (getGenericImpl != null && getValueMethod != null)
                        {
                            var tParam = getGenericImpl.GenericParameters[0];
                            getGenericImpl.Body = new MethodBody(getGenericImpl);
                            var il = getGenericImpl.Body.GetILProcessor();
                            il.Emit(OpCodes.Ldarg_2); // T& value
                            il.Emit(OpCodes.Ldarg_0); // this Array
                            il.Emit(OpCodes.Ldarg_1); // int index
                            il.Emit(OpCodes.Callvirt, getValueMethod);
                            il.Emit(OpCodes.Unbox_Any, tParam);
                            il.Emit(OpCodes.Stobj, tParam);
                            il.Emit(OpCodes.Ret);
                            Console.WriteLine("  -> Rewrote System.Array::GetGenericValueImpl to avoid generic icall.");
                            modified = true;
                        }

                        var setGenericImpl = arrayType.Methods.FirstOrDefault(m => m.Name == "SetGenericValueImpl");
                        if (setGenericImpl != null && setValueMethod != null)
                        {
                            var tParam = setGenericImpl.GenericParameters[0];
                            setGenericImpl.Body = new MethodBody(setGenericImpl);
                            var il = setGenericImpl.Body.GetILProcessor();
                            il.Emit(OpCodes.Ldarg_0); // this Array
                            il.Emit(OpCodes.Ldarg_2); // T& value
                            il.Emit(OpCodes.Ldobj, tParam);
                            il.Emit(OpCodes.Box, tParam);
                            il.Emit(OpCodes.Ldarg_1); // int index
                            il.Emit(OpCodes.Callvirt, setValueMethod);
                            il.Emit(OpCodes.Ret);
                            Console.WriteLine("  -> Rewrote System.Array::SetGenericValueImpl to avoid generic icall.");
                            modified = true;
                        }

                        foreach (var icallName in new[] { "GetGenericValue_icall", "SetGenericValue_icall" })
                        {
                            var icall = arrayType.Methods.FirstOrDefault(m => m.Name == icallName);
                            if (icall != null)
                            {
                                icall.IsInternalCall = false;
                                icall.ImplAttributes = MethodImplAttributes.IL | MethodImplAttributes.Managed;
                                icall.Body = new MethodBody(icall);
                                var il = icall.Body.GetILProcessor();
                                il.Emit(OpCodes.Ret);
                                Console.WriteLine($"  -> Neutralized generic icall {icallName}.");
                                modified = true;
                            }
                        }
                    }

                    if (modified)
                    {
                        asm.Write(mscorlibPath);
                        Console.WriteLine("  [+] mscorlib.dll saved successfully.");
                    }
                }
            }
        }

        var resolver = new DefaultAssemblyResolver();
        resolver.AddSearchDirectory(dstDir);
        var readerParams = new ReaderParameters { AssemblyResolver = resolver, InMemory = true };

        // 2. Patch unsafeAssem.dll
        string unsafeAssemPath = Path.Combine(dstDir, "unsafeAssem.dll");
        if (File.Exists(unsafeAssemPath))
        {
            Console.WriteLine("[*] Patching unsafeAssem.dll...");
            using (var asm = AssemblyDefinition.ReadAssembly(unsafeAssemPath, readerParams))
            {
                var mod = asm.MainModule;

                // 2a. Neutralize XX.MacGamepadHaptics native methods
                var hapticsType = mod.Types.FirstOrDefault(t => t.FullName == "XX.MacGamepadHaptics");
                if (hapticsType != null)
                {
                    Console.WriteLine("  -> Neutralizing XX.MacGamepadHaptics native methods...");
                    foreach (var m in hapticsType.Methods.Where(m => m.IsPInvokeImpl).ToList())
                    {
                        m.IsPInvokeImpl = false;
                        m.PInvokeInfo = null;
                        m.Attributes &= ~MethodAttributes.PInvokeImpl;
                        m.ImplAttributes = MethodImplAttributes.IL | MethodImplAttributes.Managed;
                        m.Body = new MethodBody(m);
                        var il = m.Body.GetILProcessor();

                        if (m.ReturnType.FullName == "System.Int32" || m.ReturnType.FullName == "System.Boolean")
                        {
                            il.Emit(OpCodes.Ldc_I4_0);
                            il.Emit(OpCodes.Ret);
                        }
                        else if (m.ReturnType.FullName == "System.Single")
                        {
                            il.Emit(OpCodes.Ldc_R4, 0f);
                            il.Emit(OpCodes.Ret);
                        }
                        else
                        {
                            il.Emit(OpCodes.Ret);
                        }
                        Console.WriteLine($"     Patched {m.Name}");
                    }
                }

                // 2b. Make XX.IN, XX.KEY, and XX.IN.PB members public for Touch Overlay
                var inType = mod.Types.FirstOrDefault(t => t.FullName == "XX.IN");
                if (inType != null)
                {
                    inType.IsPublic = true;
                    foreach (var f in inType.Fields) f.IsPublic = true;
                    foreach (var m in inType.Methods) m.IsPublic = true;
                    foreach (var nested in inType.NestedTypes)
                    {
                        nested.IsNestedPublic = true;
                        foreach (var f in nested.Fields) f.IsPublic = true;
                    }
                }

                var keyType = mod.Types.FirstOrDefault(t => t.FullName == "XX.KEY");
                if (keyType != null)
                {
                    keyType.IsPublic = true;
                    foreach (var f in keyType.Fields) f.IsPublic = true;
                    foreach (var m in keyType.Methods) m.IsPublic = true;
                }

                asm.Write(unsafeAssemPath);
                Console.WriteLine("  [+] unsafeAssem.dll patched & saved.");
            }
        }

        // 3. Patch SFB.dll
        string sfbPath = Path.Combine(dstDir, "SFB.dll");
        if (File.Exists(sfbPath))
        {
            Console.WriteLine("[*] Patching SFB.dll (StandaloneFileBrowserMac)...");
            using (var asm = AssemblyDefinition.ReadAssembly(sfbPath, readerParams))
            {
                var mod = asm.MainModule;
                var sfbType = mod.Types.FirstOrDefault(t => t.Name == "StandaloneFileBrowserMac");
                if (sfbType != null)
                {
                    foreach (var m in sfbType.Methods.Where(m => m.IsPInvokeImpl).ToList())
                    {
                        m.IsPInvokeImpl = false;
                        m.PInvokeInfo = null;
                        m.Attributes &= ~MethodAttributes.PInvokeImpl;
                        m.ImplAttributes = MethodImplAttributes.IL | MethodImplAttributes.Managed;
                        m.Body = new MethodBody(m);
                        var il = m.Body.GetILProcessor();

                        if (m.ReturnType.FullName == "System.IntPtr")
                        {
                            il.Emit(OpCodes.Ldc_I4_0);
                            il.Emit(OpCodes.Conv_I);
                            il.Emit(OpCodes.Ret);
                        }
                        else if (m.ReturnType.FullName == "System.String")
                        {
                            il.Emit(OpCodes.Ldstr, "");
                            il.Emit(OpCodes.Ret);
                        }
                        else
                        {
                            il.Emit(OpCodes.Ret);
                        }
                        Console.WriteLine($"     Patched {m.Name}");
                    }
                }
                asm.Write(sfbPath);
                Console.WriteLine("  [+] SFB.dll patched & saved.");
            }
        }

        // 4. Patch CriMw.CriWare.Runtime.dll
        string criPath = Path.Combine(dstDir, "CriMw.CriWare.Runtime.dll");
        if (File.Exists(criPath))
        {
            Console.WriteLine("[*] Patching CriMw.CriWare.Runtime.dll...");
            using (var asm = AssemblyDefinition.ReadAssembly(criPath, readerParams))
            {
                var common = asm.MainModule.Types.FirstOrDefault(t => t.FullName == "CriWare.Common");
                if (common != null)
                {
                    var chk = common.Methods.FirstOrDefault(m => m.Name == "CheckBinaryVersionCompatibility");
                    if (chk != null && chk.HasBody)
                    {
                        Console.WriteLine("  -> Bypassing CriWare.Common::CheckBinaryVersionCompatibility strict check...");
                        chk.Body.Instructions.Clear();
                        var il = chk.Body.GetILProcessor();
                        il.Emit(OpCodes.Ldc_I4_1);
                        il.Emit(OpCodes.Ret);
                    }
                }
                asm.Write(criPath);
                Console.WriteLine("  [+] CriMw.CriWare.Runtime.dll patched & saved.");
            }
        }

        // 4b. Patch Better.UnsafeGeneric.dll (rewrite unconstrained generic ceq/conv to EqualityComparer<T>.Default)
        string bugPath = Path.Combine(dstDir, "Better.UnsafeGeneric.dll");
        if (File.Exists(bugPath))
        {
            Console.WriteLine("[*] Patching Better.UnsafeGeneric.dll (fixing unconstrained generic comparison)...");
            using (var asm = AssemblyDefinition.ReadAssembly(bugPath, readerParams))
            {
                var mod = asm.MainModule;
                var corlib = mod.TypeSystem.Corlib;
                var eqTypeRef = new TypeReference("System.Collections.Generic", "EqualityComparer`1", mod, corlib);
                eqTypeRef.GenericParameters.Add(new GenericParameter("T", eqTypeRef));
                var importedEqType = mod.ImportReference(eqTypeRef);

                var targetTypes = new[] { "Int32EqualityComparer`1", "Int64EqualityComparer`1", "UInt64EqualityComparer`1" };
                foreach (var targetName in targetTypes)
                {
                    var target = mod.Types.FirstOrDefault(t => t.Name == targetName);
                    if (target != null && target.HasGenericParameters)
                    {
                        var tParam = target.GenericParameters[0];
                        var genericEqType = new GenericInstanceType(importedEqType);
                        genericEqType.GenericArguments.Add(tParam);

                        var getDefault = new MethodReference("get_Default", genericEqType, genericEqType) { HasThis = false };
                        var equalsRef = new MethodReference("Equals", mod.TypeSystem.Boolean, genericEqType)
                        {
                            HasThis = true,
                            Parameters = { new ParameterDefinition(tParam), new ParameterDefinition(tParam) }
                        };
                        var getHashCodeRef = new MethodReference("GetHashCode", mod.TypeSystem.Int32, genericEqType)
                        {
                            HasThis = true,
                            Parameters = { new ParameterDefinition(tParam) }
                        };

                        var eqMethod = target.Methods.FirstOrDefault(m => m.Name == "Equals");
                        if (eqMethod != null)
                        {
                            eqMethod.Body = new MethodBody(eqMethod);
                            var il = eqMethod.Body.GetILProcessor();
                            il.Emit(OpCodes.Call, getDefault);
                            il.Emit(OpCodes.Ldarg_1);
                            il.Emit(OpCodes.Ldarg_2);
                            il.Emit(OpCodes.Callvirt, equalsRef);
                            il.Emit(OpCodes.Ret);
                            Console.WriteLine($"  -> Rewrote {targetName}::Equals");
                        }

                        var hashMethod = target.Methods.FirstOrDefault(m => m.Name == "GetHashCode");
                        if (hashMethod != null)
                        {
                            hashMethod.Body = new MethodBody(hashMethod);
                            var il = hashMethod.Body.GetILProcessor();
                            il.Emit(OpCodes.Call, getDefault);
                            il.Emit(OpCodes.Ldarg_1);
                            il.Emit(OpCodes.Callvirt, getHashCodeRef);
                            il.Emit(OpCodes.Ret);
                            Console.WriteLine($"  -> Rewrote {targetName}::GetHashCode");
                        }
                    }
                }
                asm.Write(bugPath);
                Console.WriteLine("  [+] Better.UnsafeGeneric.dll patched & saved.");
            }
        }

        Console.WriteLine("==================================================");
        Console.WriteLine("  [*] Auditing remaining P/Invokes across all DLLs... ");
        Console.WriteLine("==================================================");
        foreach (var dll in Directory.GetFiles(dstDir, "*.dll"))
        {
            try
            {
                using var asm = AssemblyDefinition.ReadAssembly(dll, readerParams);
                foreach (var type in asm.MainModule.Types)
                {
                    foreach (var m in type.Methods.Where(m => m.IsPInvokeImpl))
                    {
                        Console.WriteLine($"[P/Invoke] {Path.GetFileName(dll)} -> {type.FullName}::{m.Name} (Module: {m.PInvokeInfo?.Module?.Name}, Entry: {m.PInvokeInfo?.EntryPoint})");
                    }
                    foreach (var nested in type.NestedTypes)
                    {
                        foreach (var m in nested.Methods.Where(m => m.IsPInvokeImpl))
                        {
                            Console.WriteLine($"[P/Invoke] {Path.GetFileName(dll)} -> {nested.FullName}::{m.Name} (Module: {m.PInvokeInfo?.Module?.Name}, Entry: {m.PInvokeInfo?.EntryPoint})");
                        }
                    }
                }
            }
            catch {}
        }

        Console.WriteLine("==================================================");
        Console.WriteLine("  [+] Assembly patching completed successfully!   ");
        Console.WriteLine("==================================================");
        return 0;
    }
}
