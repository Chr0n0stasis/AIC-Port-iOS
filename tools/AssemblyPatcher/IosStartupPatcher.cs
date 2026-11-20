using Mono.Cecil;
using Mono.Cecil.Cil;

internal static class IosStartupPatcher
{
    internal static void PatchInputSystem(string managedDirectory)
    {
        var path = Path.Combine(managedDirectory, "Unity.InputSystem.dll");
        using var resolver = new DefaultAssemblyResolver();
        resolver.AddSearchDirectory(managedDirectory);
        using var assembly = AssemblyDefinition.ReadAssembly(path, new ReaderParameters
        {
            InMemory = true,
            AssemblyResolver = resolver,
        });
        var manager = assembly.MainModule.GetType("UnityEngine.InputSystem.InputManager");
        var register = manager.Methods.Single(method =>
            method.Name == "RegisterCustomTypes" && !method.HasParameters);
        var instructions = register.Body.Instructions;
        var processorToken = instructions[0];
        if (processorToken.OpCode != OpCodes.Ldtoken ||
            processorToken.Operand is not TypeDefinition processor ||
            processor.Module != assembly.MainModule ||
            processor.FullName != "UnityEngine.InputSystem.InputProcessor")
        {
            throw new InvalidOperationException("Unexpected custom input registration assembly lookup.");
        }

        var getAssemblyName = instructions.Single(instruction =>
            Calls(instruction, "System.Reflection.Assembly", "GetName") &&
            Calls(instruction.Next, "System.Reflection.AssemblyName", "get_Name"));
        var getSimpleName = getAssemblyName.Next;

        // This lookup reads the name of the assembly containing InputProcessor.
        // Resolve that known name at build time to avoid the desktop-only CAS
        // lookup in RuntimeAssembly.GetName on this IL2CPP runtime.
        getAssemblyName.OpCode = OpCodes.Pop;
        getAssemblyName.Operand = null;
        getSimpleName.OpCode = OpCodes.Ldstr;
        getSimpleName.Operand = assembly.Name.Name;

        WriteStagedAssembly(assembly, path);
        Console.WriteLine($"[+] Resolved the InputSystem startup assembly name to {assembly.Name.Name}");
    }

    internal static void PatchCriErrorCallback(string managedDirectory)
    {
        var path = Path.Combine(managedDirectory, "CriMw.CriWare.Runtime.dll");
        using var resolver = new DefaultAssemblyResolver();
        resolver.AddSearchDirectory(managedDirectory);
        using var assembly = AssemblyDefinition.ReadAssembly(path, new ReaderParameters
        {
            InMemory = true,
            AssemblyResolver = resolver,
        });
        var module = assembly.MainModule;
        var notifier = module.GetType("CriWare.CriErrorNotifier");
        var nativeMethods = notifier.NestedTypes.Single(type => type.Name == "NativeMethod");
        var callbacks = nativeMethods.Methods.Where(method =>
            method.PInvokeInfo?.Module.Name == "cri_ware_unity" &&
            method.PInvokeInfo.EntryPoint == "criErr_SetCallback" &&
            method.Parameters.Count == 1 && method.ReturnType.MetadataType == MetadataType.Void).ToArray();
        if (callbacks.Length != 2 ||
            callbacks.Count(method => method.Parameters[0].ParameterType.MetadataType == MetadataType.IntPtr) != 1)
        {
            throw new InvalidOperationException("Unexpected CRI error callback P/Invoke signatures.");
        }

        var internalModule = module.ModuleReferences.SingleOrDefault(reference => reference.Name == "__Internal");
        if (internalModule == null)
        {
            internalModule = new ModuleReference("__Internal");
            module.ModuleReferences.Add(internalModule);
        }

        // IL2CPP emits direct C declarations for __Internal imports.
        // Give the delegate and raw-pointer overloads distinct declarations.
        foreach (var callback in callbacks)
        {
            callback.PInvokeInfo.Module = internalModule;
            if (callback.Parameters[0].ParameterType.MetadataType == MetadataType.IntPtr)
            {
                callback.PInvokeInfo.EntryPoint = "aic_criErr_SetCallbackPointer";
            }
        }

        WriteStagedAssembly(assembly, path);
        Console.WriteLine("[+] Bound CRI error callbacks to the static iOS audio fallback");
    }

    internal static void InstallMobileInputUpdate(string managedDirectory)
    {
        var path = Path.Combine(managedDirectory, "unsafeAssem.dll");
        using var resolver = new DefaultAssemblyResolver();
        resolver.AddSearchDirectory(managedDirectory);
        using var game = AssemblyDefinition.ReadAssembly(path, new ReaderParameters
        {
            InMemory = true,
            AssemblyResolver = resolver,
        });
        using var overlay = AssemblyDefinition.ReadAssembly(Path.Combine(managedDirectory, "AIC.iOS.dll"));
        var update = overlay.MainModule.GetType("AIC.iOS.AICTouchOverlay").Methods.Single(method =>
            method.Name == "UpdateInputSystem" && method.IsStatic && !method.HasParameters);
        var run = game.MainModule.GetType("XX.IN").Methods.Single(method =>
            method.Name == "run" && method.IsStatic && method.Parameters.Count == 1 &&
            method.Parameters[0].ParameterType.MetadataType == MetadataType.Single);
        var originalUpdate = run.Body.Instructions.Single(instruction => instruction.OpCode == OpCodes.Call &&
            instruction.Operand is MethodReference method &&
            method.DeclaringType.FullName == "UnityEngine.InputSystem.InputSystem" &&
            method.Name == "Update" && !method.HasParameters);

        originalUpdate.Operand = game.MainModule.ImportReference(update);
        WriteStagedAssembly(game, path);
        Console.WriteLine("[+] Installed the iOS gamepad input provider before game input dispatch");
    }

    private static void WriteStagedAssembly(AssemblyDefinition assembly, string path)
    {
        var staged = path + ".tmp";
        assembly.Write(staged);
        File.Move(staged, path, overwrite: true);
    }

    private static bool Calls(Instruction? instruction, string type, string name)
    {
        return instruction?.OpCode == OpCodes.Callvirt &&
            instruction.Operand is MethodReference method &&
            method.DeclaringType.FullName == type && method.Name == name &&
            !method.HasParameters;
    }
}
