import argparse
import shutil
import zipfile
from pathlib import Path, PurePosixPath
from xml.sax.saxutils import quoteattr


SAMPLE_RUNTIME = "cri/unity/samples/UnityProject/Assets/CRIMW/CriWare/Runtime/"
NATIVE_LIBRARY = "Platforms/iOS/libcri_ware_unity.a"
NOTICE = "CRI_ADX_LE_End_User_License_Agreement.txt"


def stage_sdk(archive, staging, managed):
    staging.mkdir(parents=True, exist_ok=True)
    with zipfile.ZipFile(archive) as sdk:
        scripts = [
            entry for entry in sdk.infolist()
            if entry.filename.startswith(SAMPLE_RUNTIME + "Scripts/")
            and entry.filename.endswith(".cs") and not entry.is_dir()
        ]
        if not scripts:
            raise ValueError("The SDK ZIP must contain the Unity sample runtime sources")
        for entry in scripts:
            relative = PurePosixPath(entry.filename.removeprefix(SAMPLE_RUNTIME))
            if relative.is_absolute() or ".." in relative.parts or "\\" in str(relative):
                raise ValueError(f"Invalid SDK member: {entry.filename}")
            target = staging.joinpath(*relative.parts)
            target.parent.mkdir(parents=True, exist_ok=True)
            with sdk.open(entry) as source, target.open("wb") as output:
                shutil.copyfileobj(source, output)
        for member, name in [
            (SAMPLE_RUNTIME + NATIVE_LIBRARY, "libcri_ware_unity.a"),
            ("cri/common/license/" + NOTICE, NOTICE),
        ]:
            with sdk.open(member) as source, (staging / name).open("wb") as output:
                shutil.copyfileobj(source, output)

    managed = managed.resolve().as_posix()
    (staging / "CriRuntime.csproj").write_text(f"""<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>netstandard2.1</TargetFramework>
    <AssemblyName>CriMw.CriWare.Runtime</AssemblyName>
    <AssemblyVersion>0.0.0.0</AssemblyVersion>
    <Deterministic>true</Deterministic>
    <EnableDefaultCompileItems>false</EnableDefaultCompileItems>
    <DefineConstants>UNITY_IOS;ENABLE_IL2CPP;UNITY_64;UNITY_5_3_OR_NEWER;UNITY_2017_1_OR_NEWER;UNITY_2017_2_OR_NEWER;UNITY_2018_1_OR_NEWER;UNITY_2018_3_OR_NEWER;UNITY_2019_1_OR_NEWER;UNITY_2019_3_OR_NEWER;UNITY_2020_1_OR_NEWER;UNITY_2021_1_OR_NEWER;UNITY_2021_2_OR_NEWER;UNITY_2021_3_OR_NEWER;UNITY_2022_1_OR_NEWER;UNITY_2022_2_OR_NEWER;UNITY_2022_3_OR_NEWER;CRIWARE_PROFILING_CORE_1_OR_NEWER</DefineConstants>
  </PropertyGroup>
  <ItemGroup>
    <Compile Include="Scripts/**/*.cs" />
    <Reference Include={quoteattr(managed + "/UnityEngine*.dll")} />
    <Reference Include={quoteattr(managed + "/Unity.Profiling.Core.dll")} />
  </ItemGroup>
</Project>
""", encoding="utf-8")
    print(f"[+] Staged {len(scripts)} CRI runtime sources and the iOS library")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Stage the CRI Unity SDK for a local iOS build")
    parser.add_argument("archive", type=Path)
    parser.add_argument("staging", type=Path)
    parser.add_argument("managed", type=Path)
    options = parser.parse_args()
    stage_sdk(options.archive, options.staging, options.managed)
