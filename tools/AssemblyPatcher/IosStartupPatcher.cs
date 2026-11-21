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

    internal static void InstallMobileRuntimeHooks(string managedDirectory)
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
        var overlayType = overlay.MainModule.GetType("AIC.iOS.AICTouchOverlay");
        var update = overlayType.Methods.Single(method =>
            method.Name == "UpdateInputSystem" && method.IsStatic && !method.HasParameters);
        var run = game.MainModule.GetType("XX.IN").Methods.Single(method =>
            method.Name == "run" && method.IsStatic && method.Parameters.Count == 1 &&
            method.Parameters[0].ParameterType.MetadataType == MetadataType.Single);
        var originalUpdate = run.Body.Instructions.Single(instruction => instruction.OpCode == OpCodes.Call &&
            instruction.Operand is MethodReference method &&
            method.DeclaringType.FullName == "UnityEngine.InputSystem.InputSystem" &&
            method.Name == "Update" && !method.HasParameters);

        originalUpdate.Operand = game.MainModule.ImportReference(update);

        var readDebugF7 = overlayType.Methods.Single(method => method.Name == "ReadDebugF7" &&
            method.IsStatic && method.Parameters.Count == 1 &&
            method.Parameters[0].ParameterType.MetadataType == MetadataType.Boolean);
        var eventsUpdate = game.MainModule.GetType("evt.EV").Methods.Single(method =>
            method.Name == "FixedUpdate" && !method.HasParameters);
        var keyboardF7 = eventsUpdate.Body.Instructions.Single(instruction =>
            instruction.OpCode == OpCodes.Call && instruction.Operand is MethodReference method &&
            method.DeclaringType.FullName == "XX.IN" && method.Name == "getKD" &&
            method.Parameters.Count == 3 && instruction.Previous?.Previous?.Previous is Instruction key &&
            key.OpCode == OpCodes.Ldc_I4_S && key.Operand is sbyte keyCode && keyCode == 100);
        var eventsIL = eventsUpdate.Body.GetILProcessor();
        eventsIL.InsertAfter(keyboardF7, eventsIL.Create(OpCodes.Call, game.MainModule.ImportReference(readDebugF7)));

        WaitForMapResourceCleanup(game.MainModule, overlay.MainModule);
        WriteStagedAssembly(game, path);
        Console.WriteLine("[+] Installed the iOS gamepad input provider and F7 debug shortcut");
        Console.WriteLine("[+] Wait for unused resources to unload before preparing the next map");
    }

    private static void WaitForMapResourceCleanup(ModuleDefinition game, ModuleDefinition overlay)
    {
        var cleanup = overlay.GetType("AIC.iOS.MobileMapCleanup")
            ?? throw new InvalidOperationException("AIC.iOS.dll is missing MobileMapCleanup. Build with src/MobileMapCleanup.cs.");
        var begin = cleanup.Methods.Single(method => method.Name == "Begin" && method.IsStatic &&
            !method.HasParameters && method.ReturnType.FullName == "UnityEngine.AsyncOperation");
        var isPending = cleanup.Methods.Single(method => method.Name == "IsPending" && method.IsStatic &&
            !method.HasParameters && method.ReturnType.MetadataType == MetadataType.Boolean);
        var map = game.GetType("m2d.M2DBase");
        var changeMap = map.Methods.Single(method => method.Name == "changeMap" &&
            method.Parameters.Count == 1 && method.Parameters[0].ParameterType.FullName == "m2d.Map2d");
        var unload = changeMap.Body.Instructions.Single(instruction => instruction.OpCode == OpCodes.Call &&
            instruction.Operand is MethodReference called && called.Name == "UnloadUnusedAssets" &&
            called.DeclaringType.FullName == "UnityEngine.Resources" && !called.HasParameters &&
            called.ReturnType.FullName == "UnityEngine.AsyncOperation");

        unload.Operand = game.ImportReference(begin);

        var pending = game.ImportReference(isPending);
        foreach (var name in new[] { "loadMapAsync", "loadMapAsyncFinalize" })
        {
            // Both methods return true while more loading work is pending.
            var load = map.Methods.Single(method => method.Name == name &&
                method.ReturnType.MetadataType == MetadataType.Boolean && method.HasBody);
            var first = load.Body.Instructions[0];
            var il = load.Body.GetILProcessor();
            il.InsertBefore(first, il.Create(OpCodes.Call, pending));
            il.InsertBefore(first, il.Create(OpCodes.Brfalse_S, first));
            il.InsertBefore(first, il.Create(OpCodes.Ldc_I4_1));
            il.InsertBefore(first, il.Create(OpCodes.Ret));
        }
    }

    internal static void PatchMobileRendering(string managedDirectory)
    {
        var inputPath = Path.Combine(managedDirectory, "unsafeAssem.dll");
        var settingsPath = Path.Combine(managedDirectory, "Assembly-CSharp.dll");
        using var resolver = new DefaultAssemblyResolver();
        resolver.AddSearchDirectory(managedDirectory);
        var parameters = new ReaderParameters { InMemory = true, AssemblyResolver = resolver };
        using var input = AssemblyDefinition.ReadAssembly(inputPath, parameters);
        using var settings = AssemblyDefinition.ReadAssembly(settingsPath, parameters);
        var setMode = input.MainModule.GetType("XX.IN").Methods.Single(method =>
            method.Name == "setFullScreenMode" && method.IsStatic && method.Parameters.Count == 2 &&
            method.Body.Instructions.Any(instruction => instruction.Operand is MethodReference called &&
                called.DeclaringType.FullName == "UnityEngine.Screen" && called.Name == "SetResolution"));

        var desktopWindowSetting = settings.MainModule.Types.Single(type => type.Name == "UiCFG").Methods
            .Where(method => method.IsConstructor && method.HasBody)
            .SelectMany(method => method.Body.Instructions)
            .Single(instruction => instruction.OpCode == OpCodes.Stfld &&
                instruction.Operand is FieldReference field && field.Name == "enable_fullscreen");
        if (desktopWindowSetting.Previous.OpCode != OpCodes.Ldc_I4_1)
            throw new InvalidOperationException("Unexpected initial state for the desktop window options.");

        // iOS owns the drawable size. XX.IN.checkWindowSizeChanged still updates
        // the game's existing aspect-ratio viewport whenever that size changes.
        setMode.Body = new MethodBody(setMode);
        setMode.Body.GetILProcessor().Emit(OpCodes.Ret);
        desktopWindowSetting.Previous.OpCode = OpCodes.Ldc_I4_0;

        DisableMosaicDrawing(settings.MainModule);

        WriteStagedAssembly(input, inputPath);
        WriteStagedAssembly(settings, settingsPath);
        Console.WriteLine("[+] Kept the iOS native display size and disabled the desktop window settings");
        Console.WriteLine("[+] Routed the mosaic renderer through its disabled path");
    }

    private static void DisableMosaicDrawing(ModuleDefinition module)
    {
        var draw = module.GetType("nel.MosaicShower").Methods.Single(method =>
            method.Name == "FnDrawMosaic" && !method.IsStatic && method.Parameters.Count == 3 &&
            method.ReturnType.MetadataType == MetadataType.Boolean && method.HasBody);
        var enabled = draw.Body.Instructions.Single(instruction =>
            instruction.OpCode == OpCodes.Ldfld && instruction.Operand is FieldReference field &&
            field.DeclaringType.FullName == "nel.MosaicShower" && field.Name == "enabled" &&
            field.FieldType.MetadataType == MetadataType.Boolean);
        var drawWhenEnabled = enabled.Next;
        if (drawWhenEnabled == null ||
            (drawWhenEnabled.OpCode != OpCodes.Brtrue && drawWhenEnabled.OpCode != OpCodes.Brtrue_S) ||
            drawWhenEnabled.Next?.OpCode != OpCodes.Ldc_I4_1 ||
            drawWhenEnabled.Next.Next?.OpCode != OpCodes.Ret)
        {
            throw new InvalidOperationException("Unexpected mosaic renderer enable check.");
        }

        // Follow the stock disabled path before either the GL or mesh render
        // path starts. Preserve its return value and the preceding camera checks.
        drawWhenEnabled.OpCode = OpCodes.Pop;
        drawWhenEnabled.Operand = null;
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
