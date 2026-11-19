using System.Runtime.InteropServices;

namespace PortProbe;

public static class Export
{
    [UnmanagedCallersOnly(EntryPoint = "port_probe_mix")]
    public static uint Mix(uint seed, uint value) => Fold.Mix(seed, value);
}
