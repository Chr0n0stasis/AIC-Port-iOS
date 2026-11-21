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

        UseDocumentsDebugConfig(game.MainModule, overlay.MainModule);
        InstallMapResourceCleanup(game.MainModule, overlay.MainModule);
        WriteStagedAssembly(game, path);
        Console.WriteLine("[+] Installed the iOS gamepad input provider and F7 debug shortcut");
        Console.WriteLine("[+] Read _debug.txt from the app's Documents directory");
        Console.WriteLine("[+] Reclaim closed-map resources before loading and limit the cache on low-memory devices");
    }

    private static void UseDocumentsDebugConfig(ModuleDefinition game, ModuleDefinition overlay)
    {
        var readConfig = GetMobileSettings(overlay).Methods.Single(method => method.Name == "ReadDebugConfig" &&
            method.IsStatic && method.ReturnType.MetadataType == MetadataType.String &&
            method.Parameters.Count == 1 && method.Parameters[0].ParameterType.MetadataType == MetadataType.String);
        var loadDebug = game.GetType("XX.X").Methods.Single(method =>
            method.Name == "loadDebug" && method.IsStatic && !method.HasParameters);
        var readBundled = loadDebug.Body.Instructions.Single(instruction => instruction.OpCode == OpCodes.Call &&
            instruction.Operand is MethodReference called && called.DeclaringType.FullName == "NKT" &&
            called.Name == "readStreamingText" && called.ReturnType.MetadataType == MetadataType.String &&
            instruction.Previous?.OpCode == OpCodes.Ldc_I4_0 &&
            instruction.Previous.Previous?.Operand is string fileName && fileName == "_debug.txt");

        var il = loadDebug.Body.GetILProcessor();
        il.InsertAfter(readBundled, il.Create(OpCodes.Call, game.ImportReference(readConfig)));
    }

    private static void InstallMapResourceCleanup(ModuleDefinition game, ModuleDefinition overlay)
    {
        var cleanup = overlay.GetType("AIC.iOS.MobileMapCleanup")
            ?? throw new InvalidOperationException("AIC.iOS.dll is missing MobileMapCleanup. Build with src/MobileMapCleanup.cs.");
        var request = cleanup.Methods.Single(method => method.Name == "RequestAfterMapClose" && method.IsStatic &&
            !method.HasParameters && method.ReturnType.MetadataType == MetadataType.Void);
        var isPending = cleanup.Methods.Single(method => method.Name == "IsPending" && method.IsStatic &&
            !method.HasParameters && method.ReturnType.MetadataType == MetadataType.Boolean);
        var cacheLimit = cleanup.Methods.Single(method => method.Name == "ClosedMapCacheLimit" && method.IsStatic &&
            !method.HasParameters && method.ReturnType.MetadataType == MetadataType.Int32);
        var map = game.GetType("m2d.M2DBase");
        var changeMap = map.Methods.Single(method => method.Name == "changeMap" &&
            method.Parameters.Count == 1 && method.Parameters[0].ParameterType.FullName == "m2d.Map2d");
        var unload = changeMap.Body.Instructions.Single(instruction => instruction.OpCode == OpCodes.Call &&
            instruction.Operand is MethodReference called && called.Name == "UnloadUnusedAssets" &&
            called.DeclaringType.FullName == "UnityEngine.Resources" && !called.HasParameters &&
            called.ReturnType.FullName == "UnityEngine.AsyncOperation");

        var unloadResult = unload.Next;
        var closeEnd = changeMap.Body.Instructions.Single(instruction => instruction.OpCode == OpCodes.Stfld &&
            instruction.Operand is FieldReference field && field.DeclaringType.FullName == "m2d.M2DBase" &&
            field.Name == "WRC_Air" && instruction.Next?.OpCode == OpCodes.Ldnull &&
            instruction.Next.Next?.OpCode == OpCodes.Ret);
        if (unloadResult?.OpCode != OpCodes.Pop || closeEnd.Offset <= unload.Offset)
            throw new InvalidOperationException("Unexpected resource sweep in the map close path.");

        // Keep the old branch target, and request the sweep after the stock
        // map-close code has detached its mob textures and scene references.
        unload.OpCode = OpCodes.Nop;
        unload.Operand = null;
        unloadResult.OpCode = OpCodes.Nop;
        var changeIL = changeMap.Body.GetILProcessor();
        changeIL.InsertAfter(closeEnd, changeIL.Create(OpCodes.Call, game.ImportReference(request)));

        // The game removes the incoming map from AMapHistory first, then uses
        // this threshold in its existing loop that closes and removes cached maps.
        var retainedMapCount = changeMap.Body.Instructions.Single(instruction => instruction.OpCode == OpCodes.Ldc_I4_1 &&
            CallsMapHistoryCount(instruction.Previous) &&
            (instruction.Next?.OpCode == OpCodes.Ble_S || instruction.Next?.OpCode == OpCodes.Ble));
        retainedMapCount.OpCode = OpCodes.Call;
        retainedMapCount.Operand = game.ImportReference(cacheLimit);

        var pending = game.ImportReference(isPending);
        foreach (var name in new[] { "loadMapAsync", "loadMapAsyncFinalize" })
        {
            // Both methods return true while more loading work is pending.
            var load = map.Methods.Single(method => method.Name == name &&
                method.ReturnType.MetadataType == MetadataType.Boolean && method.HasBody);
            ReturnWhen(load, pending, returnValue: true);
        }

        var isLowMemoryDevice = cleanup.Methods.Single(method => method.Name == "get_IsLowMemoryDevice" &&
            method.IsStatic && !method.HasParameters && method.ReturnType.MetadataType == MetadataType.Boolean);
        TrimUnusedRenderTextures(game, game.ImportReference(isLowMemoryDevice));
        RebuildGrowingMapAtlas(game, map, cleanup);
        TraceMapTransitionMemory(game, changeMap, cleanup);
    }

    private static void TraceMapTransitionMemory(ModuleDefinition game, MethodDefinition changeMap, TypeDefinition cleanup)
    {
        var begin = game.ImportReference(cleanup.Methods.Single(method => method.Name == "BeginMapMemoryTrace"));
        var trace = game.ImportReference(cleanup.Methods.Single(method => method.Name == "TraceMapMemory"));
        var finish = game.ImportReference(cleanup.Methods.Single(method => method.Name == "FinishMapMemoryTrace"));

        var calls = changeMap.Body.Instructions.Where(instruction =>
            instruction.OpCode == OpCodes.Callvirt && instruction.Operand is MethodReference called &&
            called.DeclaringType.FullName == "m2d.Map2d").ToArray();
        var closeCall = calls.First(instruction => ((MethodReference)instruction.Operand).Name == "close");
        var openCall = calls.Single(instruction => ((MethodReference)instruction.Operand).Name == "open");
        var changeIL = changeMap.Body.GetILProcessor();
        changeIL.InsertBefore(closeCall, changeIL.Create(OpCodes.Call, begin));
        changeIL.InsertAfter(openCall.Next, changeIL.Create(OpCodes.Call, finish));

        var open = ((MethodReference)openCall.Operand).Resolve();
        var events = game.GetType("m2d.M2EventContainer").Methods.Single(method => method.Name == "reload" &&
            method.HasBody && method.Body.Instructions.Any(instruction => instruction.Operand is string message &&
                message.StartsWith("M2EventContainer::reload", StringComparison.Ordinal)));
        var eventLog = events.Body.Instructions.Last(instruction => instruction.OpCode == OpCodes.Call &&
            instruction.Operand is MethodReference called && called.DeclaringType.FullName == "XX.X" && called.Name == "dl");

        foreach (var (method, checkpoint, stage) in new[] {
            (open, FindCall(open, "prepareMeshDrawer"), "after map mesh setup"),
            (open, FindCall(open, "init"), "after camera setup"),
            (open, FindCall(open, "openSubMaps"), "after submap open"),
            (events, eventLog, "after event reload"),
        })
        {
            var il = method.Body.GetILProcessor();
            var label = il.Create(OpCodes.Ldstr, stage);
            il.InsertAfter(checkpoint, label);
            il.InsertAfter(label, il.Create(OpCodes.Call, trace));
        }
    }

    private static Instruction FindCall(MethodDefinition method, string name) =>
        method.Body.Instructions.Single(instruction =>
            (instruction.OpCode == OpCodes.Call || instruction.OpCode == OpCodes.Callvirt) &&
            instruction.Operand is MethodReference called && called.Name == name);

    private static void RebuildGrowingMapAtlas(ModuleDefinition game, TypeDefinition map, TypeDefinition cleanup)
    {
        var atlas = game.GetType("m2d.M2ImageAtlas");
        var prepare = atlas.Methods.Single(method => method.Name == "prepareAtlasProgress" &&
            method.Parameters.Count == 2 && method.ReturnType.MetadataType == MetadataType.Boolean);
        var recalculate = atlas.Methods.Single(method => method.Name == "recalcAtlasContent" &&
            !method.HasParameters && method.ReturnType.MetadataType == MetadataType.Void);
        var takeRebuild = cleanup.Methods.Single(method => method.Name == "TakeLargeAtlasRebuild" &&
            method.IsStatic && method.Parameters.Count == 1 &&
            method.Parameters[0].ParameterType.FullName == "UnityEngine.RenderTexture" &&
            method.ReturnType.MetadataType == MetadataType.Boolean);
        var owner = atlas.Fields.Single(field => field.Name == "M2D" && field.FieldType.FullName == map.FullName);
        var currentMap = map.Fields.Single(field => field.Name == "curMap");
        var loadedIndex = atlas.Fields.Single(field => field.Name == "loaded_index");
        var directories = atlas.Fields.Single(field => field.Name == "Aloaded_dir");
        var count = prepare.Body.Instructions.First(instruction => instruction.OpCode == OpCodes.Callvirt &&
            instruction.Operand is MethodReference method && method.Name == "get_Count" &&
            instruction.Previous?.Operand is FieldReference field && field.FullName == directories.FullName);
        var container = atlas.BaseType.Resolve();
        var getTexture = container.Methods.Single(method => method.Name == "get_Tx" &&
            !method.HasParameters && method.ReturnType.FullName == "UnityEngine.RenderTexture");
        var allocator = prepare.Body.Instructions.Single(instruction => instruction.OpCode == OpCodes.Call &&
            instruction.Operand is MethodReference method &&
            method.DeclaringType.FullName == container.FullName && method.Name == "initAtlasTextureFirstMemory" &&
            instruction.Next?.OpCode == OpCodes.Pop);
        var first = allocator.Next.Next;
        if (first == null || first.OpCode != OpCodes.Ldarg_0)
            throw new InvalidOperationException("Unexpected map atlas allocation entry point.");

        // Only a closed map can request this. A full reset uses the stock
        // atlas rebuild, which clears the old render target before repainting.
        var il = prepare.Body.GetILProcessor();
        il.InsertBefore(first, il.Create(OpCodes.Ldarg_0));
        il.InsertBefore(first, il.Create(OpCodes.Ldfld, owner));
        il.InsertBefore(first, il.Create(OpCodes.Ldfld, currentMap));
        il.InsertBefore(first, il.Create(OpCodes.Brtrue_S, first));
        il.InsertBefore(first, il.Create(OpCodes.Ldarg_0));
        il.InsertBefore(first, il.Create(OpCodes.Ldfld, loadedIndex));
        il.InsertBefore(first, il.Create(OpCodes.Ldc_I4_0));
        il.InsertBefore(first, il.Create(OpCodes.Blt_S, first));
        il.InsertBefore(first, il.Create(OpCodes.Ldarg_0));
        il.InsertBefore(first, il.Create(OpCodes.Ldfld, directories));
        il.InsertBefore(first, il.Create(OpCodes.Callvirt, (MethodReference)count.Operand));
        il.InsertBefore(first, il.Create(OpCodes.Ldarg_0));
        il.InsertBefore(first, il.Create(OpCodes.Ldfld, loadedIndex));
        il.InsertBefore(first, il.Create(OpCodes.Ble_S, first));
        il.InsertBefore(first, il.Create(OpCodes.Ldarg_0));
        il.InsertBefore(first, il.Create(OpCodes.Call, getTexture));
        il.InsertBefore(first, il.Create(OpCodes.Call, game.ImportReference(takeRebuild)));
        il.InsertBefore(first, il.Create(OpCodes.Brfalse_S, first));
        il.InsertBefore(first, il.Create(OpCodes.Ldarg_0));
        il.InsertBefore(first, il.Create(OpCodes.Call, recalculate));
    }

    private static void TrimUnusedRenderTextures(ModuleDefinition game, MethodReference isLowMemoryDevice)
    {
        var pool = game.GetType("XX.RenderTexturePool");
        var releaseAll = pool.Methods.Single(method => method.Name == "releaseAll" &&
            !method.IsStatic && !method.HasParameters && method.ReturnType.MetadataType == MetadataType.Void);
        var dispose = pool.Methods.Single(method => method.Name == "dispose" &&
            !method.IsStatic && !method.HasParameters && method.ReturnType.MetadataType == MetadataType.Void);

        // The camera teardown marks all buffers reusable here. On smaller
        // devices, discard their backing memory and let Pop recreate on demand.
        var first = releaseAll.Body.Instructions[0];
        var il = releaseAll.Body.GetILProcessor();
        il.InsertBefore(first, il.Create(OpCodes.Call, isLowMemoryDevice));
        il.InsertBefore(first, il.Create(OpCodes.Brfalse_S, first));
        il.InsertBefore(first, il.Create(OpCodes.Ldarg_0));
        il.InsertBefore(first, il.Create(OpCodes.Call, dispose));
        il.InsertBefore(first, il.Create(OpCodes.Ret));
    }

    private static bool CallsMapHistoryCount(Instruction? instruction) =>
        instruction?.OpCode == OpCodes.Callvirt && instruction.Operand is MethodReference method &&
        method.Name == "get_Count" && !method.HasParameters &&
        instruction.Previous?.OpCode == OpCodes.Ldfld && instruction.Previous.Operand is FieldReference field &&
        field.DeclaringType.FullName == "m2d.M2DBase" && field.Name == "AMapHistory";

    private static void ReturnWhen(MethodDefinition method, MethodReference predicate, bool returnValue)
    {
        var first = method.Body.Instructions[0];
        var il = method.Body.GetILProcessor();
        il.InsertBefore(first, il.Create(OpCodes.Call, predicate));
        il.InsertBefore(first, il.Create(OpCodes.Brfalse_S, first));
        il.InsertBefore(first, il.Create(returnValue ? OpCodes.Ldc_I4_1 : OpCodes.Ldc_I4_0));
        il.InsertBefore(first, il.Create(OpCodes.Ret));
    }

    internal static void PatchMobileSettings(string managedDirectory)
    {
        var inputPath = Path.Combine(managedDirectory, "unsafeAssem.dll");
        var settingsPath = Path.Combine(managedDirectory, "Assembly-CSharp.dll");
        using var resolver = new DefaultAssemblyResolver();
        resolver.AddSearchDirectory(managedDirectory);
        var parameters = new ReaderParameters { InMemory = true, AssemblyResolver = resolver };
        using var input = AssemblyDefinition.ReadAssembly(inputPath, parameters);
        using var settings = AssemblyDefinition.ReadAssembly(settingsPath, parameters);
        using var overlay = AssemblyDefinition.ReadAssembly(Path.Combine(managedDirectory, "AIC.iOS.dll"));
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
        InstallWormWallImmunity(settings.MainModule, overlay.MainModule);

        WriteStagedAssembly(input, inputPath);
        WriteStagedAssembly(settings, settingsPath);
        Console.WriteLine("[+] Kept the iOS native display size and disabled the desktop window settings");
        Console.WriteLine("[+] Routed the mosaic renderer through its disabled path");
        Console.WriteLine("[+] Installed the optional worm wall immunity setting");
    }

    private static TypeDefinition GetMobileSettings(ModuleDefinition module) =>
        module.GetType("AIC.iOS.MobileSettings")
        ?? throw new InvalidOperationException("AIC.iOS.dll is missing MobileSettings. Build with src/MobileSettings.cs.");

    private static void InstallWormWallImmunity(ModuleDefinition game, ModuleDefinition overlay)
    {
        var isImmune = GetMobileSettings(overlay).Methods.Single(method =>
            method.Name == "get_WormWallImmune" && method.IsStatic && !method.HasParameters &&
            method.ReturnType.MetadataType == MetadataType.Boolean);
        var canPull = game.GetType("nel.PR").Methods.Single(method => method.Name == "canPullByWorm" &&
            !method.IsStatic && !method.HasParameters && method.ReturnType.MetadataType == MetadataType.Boolean);

        // The stock trap checks this on contact and again just before grabbing.
        ReturnWhen(canPull, game.ImportReference(isImmune), returnValue: false);
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
