using Mono.Cecil;

internal static class CriSdkVerifier
{
    private const string RuntimeName = "CriMw.CriWare.Runtime";

    internal static void Verify(string managedDirectory, string exportsPath)
    {
        using var resolver = new DefaultAssemblyResolver();
        resolver.AddSearchDirectory(managedDirectory);
        using var runtime = AssemblyDefinition.ReadAssembly(Path.Combine(managedDirectory, RuntimeName + ".dll"));
        var exports = File.ReadLines(exportsPath)
            .Where(line => line.StartsWith('_'))
            .Select(line => line[1..].Trim())
            .ToHashSet(StringComparer.Ordinal);
        var imports = runtime.MainModule.GetTypes().SelectMany(type => type.Methods)
            .Where(method => method.IsPInvokeImpl)
            .Select(method => method.PInvokeInfo)
            .ToArray();
        var unresolved = imports.Where(import => import.Module.Name != "__Internal" || !exports.Contains(import.EntryPoint))
            .Select(import => $"{import.Module.Name}:{import.EntryPoint}").Distinct().ToList();
        if (unresolved.Count > 0)
        {
            throw new InvalidOperationException("CRI native exports missing: " + string.Join(", ", unresolved));
        }

        int checkedReferences = 0;
        foreach (var path in Directory.EnumerateFiles(managedDirectory, "*.dll"))
        {
            using var game = AssemblyDefinition.ReadAssembly(path, new ReaderParameters { AssemblyResolver = resolver });
            var module = game.MainModule;
            if (!module.AssemblyReferences.Any(reference => reference.Name == RuntimeName))
                continue;

            foreach (var reference in module.GetTypeReferences().Where(IsCriType))
            {
                checkedReferences++;
                if (reference.Resolve() == null)
                    unresolved.Add($"{game.Name.Name}: {reference.FullName}");
            }
            foreach (var reference in module.GetMemberReferences().Where(reference => IsCriType(reference.DeclaringType)))
            {
                checkedReferences++;
                if ((reference is MethodReference method && method.Resolve() == null) ||
                    (reference is FieldReference field && field.Resolve() == null))
                    unresolved.Add($"{game.Name.Name}: {reference.FullName}");
            }
        }
        if (unresolved.Count > 0)
        {
            throw new InvalidOperationException("CRI managed references missing: " + string.Join(", ", unresolved));
        }

        Console.WriteLine($"[+] Verified {checkedReferences} game references and {imports.Select(import => import.EntryPoint).Distinct().Count()} CRI ARM64 exports");
    }

    private static bool IsCriType(TypeReference type) => type.GetElementType().Scope?.Name == RuntimeName;
}
