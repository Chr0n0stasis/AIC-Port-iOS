#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
plugin="$root/UnityProbe/Assets/Plugins"
dotnet build "$root/probe/Kernel/Kernel.csproj" -c Release
mkdir -p "$plugin"
cp "$root/probe/Kernel/bin/Release/netstandard2.1/PortProbe.Kernel.dll" "$plugin/"
