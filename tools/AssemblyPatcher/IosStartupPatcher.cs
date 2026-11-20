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

        var staged = path + ".tmp";
        assembly.Write(staged);
        File.Move(staged, path, overwrite: true);
        Console.WriteLine($"[+] Resolved the InputSystem startup assembly name to {assembly.Name.Name}");
    }

    private static bool Calls(Instruction? instruction, string type, string name)
    {
        return instruction?.OpCode == OpCodes.Callvirt &&
            instruction.Operand is MethodReference method &&
            method.DeclaringType.FullName == type && method.Name == name &&
            !method.HasParameters;
    }
}
