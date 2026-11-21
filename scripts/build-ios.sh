#!/usr/bin/env bash
set -euo pipefail

echo "================================================================="
echo "   Alice in Cradle (iOS Port) - Automated macOS Builder         "
echo "================================================================="

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WORK_DIR="/tmp/aic_ios_build"
OUTPUT_DIR="${ROOT_DIR}/artifacts"
DERIVED_DATA="${WORK_DIR}/DerivedData"
GAME_VERSION="0.30i"
BUILD_VERSION="${AIC_BUILD_VERSION:-${GITHUB_RUN_NUMBER:-1}.${GITHUB_RUN_ATTEMPT:-0}}"
if [[ ! "${BUILD_VERSION}" =~ ^[1-9][0-9]*(\.[0-9]+){0,2}$ ]]; then
  echo "Invalid build version: ${BUILD_VERSION}. Expected one to three dot-separated integers." >&2
  exit 1
fi
ARTIFACT_NAME="AliceInCradle_v${GAME_VERSION}_iOS_b${BUILD_VERSION}"
mkdir -p "${WORK_DIR}" "${OUTPUT_DIR}" "${DERIVED_DATA}"

UNITY_VERSION="2022.3.62f2"
CHANGESET="7670c08855a9"
PKG_URL="https://download.unity3d.com/download_unity/${CHANGESET}/MacEditorTargetInstaller/UnitySetup-iOS-Support-for-Editor-${UNITY_VERSION}.pkg"

echo "[*] Working directory: ${WORK_DIR}"
echo "[*] Target Unity version: ${UNITY_VERSION} (${CHANGESET})"
echo "[*] Host architecture: $(uname -m)"

# 1. Download & Extract Unity iOS Support Playback Engine
PKG_FILE="${WORK_DIR}/UnitySetup-iOS-Support.pkg"
EXTRACT_DIR="${WORK_DIR}/playback_engine"

if [[ ! -d "${EXTRACT_DIR}" ]]; then
  echo "[*] Downloading Unity iOS Support Playback Engine..."
  curl -fSL -C - --retry 5 -o "${PKG_FILE}" "${PKG_URL}"
  
  echo "[*] Expanding iOS Support PKG using pkgutil..."
  pkgutil --expand-full "${PKG_FILE}" "${EXTRACT_DIR}"
  
  # Unpack inner Payload if it exists
  PAYLOAD_FILE=$(find "${EXTRACT_DIR}" -name "Payload" -type f | head -n 1)
  if [[ -n "${PAYLOAD_FILE}" ]]; then
    echo "[*] Unpacking inner Payload (${PAYLOAD_FILE})..."
    PAYLOAD_DIR=$(dirname "${PAYLOAD_FILE}")
    (cd "${PAYLOAD_DIR}" && gunzip -c "${PAYLOAD_FILE}" | cpio -idmu)
  fi
  rm -f "${PKG_FILE}"
else
  echo "[+] Reusing existing extracted Playback Engine."
fi

# Ensure all binaries and dylibs have execution permissions
chmod -R +x "${EXTRACT_DIR}"

# 2. Locate components inside Playback Engine matching host architecture
echo "[*] Locating Trampoline, IL2CPP compiler, and iOS runtime..."
TRAMPOLINE_SRC=$(find "${EXTRACT_DIR}" -type d -name "Trampoline" | head -n 1)
LIB_IPHONE_SRC=$(find "${EXTRACT_DIR}" -type f -name "libiPhone-lib.a" | head -n 1)

HOST_ARCH=$(uname -m)
if [[ "${HOST_ARCH}" == "arm64" ]]; then
  IL2CPP_DLL=$(find "${EXTRACT_DIR}" -path "*/deploy_arm64/il2cpp.dll" | head -n 1)
else
  IL2CPP_DLL=$(find "${EXTRACT_DIR}" -path "*/deploy_x86_64/il2cpp.dll" | head -n 1)
fi

if [[ -z "${IL2CPP_DLL}" ]]; then
  # Fallback to any il2cpp.dll
  IL2CPP_DLL=$(find "${EXTRACT_DIR}" -type f -name "il2cpp.dll" | head -n 1)
fi

echo "  -> Trampoline template: ${TRAMPOLINE_SRC}"
echo "  -> libiPhone-lib.a:     ${LIB_IPHONE_SRC}"
echo "  -> IL2CPP compiler:     ${IL2CPP_DLL}"

if [[ -z "${TRAMPOLINE_SRC}" || -z "${LIB_IPHONE_SRC}" || -z "${IL2CPP_DLL}" ]]; then
  echo "::error::Could not locate required playback engine components in ${EXTRACT_DIR}"
  find "${EXTRACT_DIR}" -maxdepth 4
  exit 1
fi

# 3. Scaffold the Xcode project directory
XCODE_DIR="${WORK_DIR}/XcodeProject"
rm -rf "${XCODE_DIR}"
mkdir -p "${XCODE_DIR}"
echo "[*] Copying Trampoline template to ${XCODE_DIR}..."
cp -R "${TRAMPOLINE_SRC}/" "${XCODE_DIR}/"

# Install libiPhone-lib.a into Libraries/
mkdir -p "${XCODE_DIR}/Libraries"
cp "${LIB_IPHONE_SRC}" "${XCODE_DIR}/Libraries/libiPhone-lib.a"

# 3b. Stage IL2CPP compiler and runtime engine into Il2CppOutputProject/IL2CPP
IL2CPP_SOURCE_DIR=$(find "${EXTRACT_DIR}" -type d -path "*/iOSSupport/il2cpp" | head -n 1)
if [[ -z "${IL2CPP_SOURCE_DIR}" ]]; then
  IL2CPP_SOURCE_DIR=$(find "${EXTRACT_DIR}" -type d -name "il2cpp" | head -n 1)
fi
echo "[*] Staging IL2CPP engine from ${IL2CPP_SOURCE_DIR} into ${XCODE_DIR}/Il2CppOutputProject/IL2CPP..."
mkdir -p "${XCODE_DIR}/Il2CppOutputProject"
if [[ -d "${IL2CPP_SOURCE_DIR}" ]]; then
  cp -R "${IL2CPP_SOURCE_DIR}" "${XCODE_DIR}/Il2CppOutputProject/IL2CPP"
  chmod -R +x "${XCODE_DIR}/Il2CppOutputProject/IL2CPP"
fi

# Ensure dotnet binary is discoverable in standard PATH for Xcode build scripts
if command -v dotnet >/dev/null 2>&1; then
  sudo ln -sf "$(command -v dotnet)" /usr/local/bin/dotnet 2>/dev/null || true
fi

# 4. Run IL2CPP on PatchedManaged assemblies
IL2CPP_OUT="${XCODE_DIR}/Il2CppOutputProject/Source/il2cppOutput"
DATA_OUT="${XCODE_DIR}/Data"
MANAGED_IN="${XCODE_DIR}/ManagedInput"
mkdir -p "${IL2CPP_OUT}" "${DATA_OUT}" "${MANAGED_IN}"
cp -R "${ROOT_DIR}/PatchedManaged/." "${MANAGED_IN}/"

# Use the device audio module and its matching web-request modules. The
# desktop web-request modules reference MovieTexture, which is absent on iOS.
IOS_MANAGED=$(find "${EXTRACT_DIR}" -type d -path '*/Variations/il2cpp/Releasearm64_managed' -print -quit)
if [[ -z "${IOS_MANAGED}" ]]; then
  echo "::error::Missing the Release ARM64 iOS managed assemblies"
  exit 1
fi
for module in AudioModule UnityWebRequestAudioModule UnityWebRequestWWWModule; do
  cp -f "${IOS_MANAGED}/UnityEngine.${module}.dll" "${MANAGED_IN}/"
done
dotnet build "${ROOT_DIR}/src/AIC.iOS.csproj" --configuration Release --output "${WORK_DIR}/ios-controls"
cp -f "${WORK_DIR}/ios-controls/AIC.iOS.dll" "${MANAGED_IN}/"
PATCH_ARGS=(--ios-startup "${MANAGED_IN}")
CRI_SDK_LIBRARY=""
if [[ -n "${AIC_CRI_SDK_ZIP:-}" ]]; then
  CRI_SDK_STAGE="${XCODE_DIR}/CriSdk"
  python3 "${ROOT_DIR}/scripts/stage-cri-ios-sdk.py" "${AIC_CRI_SDK_ZIP}" "${CRI_SDK_STAGE}" "${MANAGED_IN}"
  CRI_SDK_LIBRARY="${CRI_SDK_STAGE}/libcri_ware_unity.a"
  xcrun lipo "${CRI_SDK_LIBRARY}" -verify_arch arm64
  xcrun nm -arch arm64 -gUj "${CRI_SDK_LIBRARY}" > "${CRI_SDK_STAGE}/exports.txt"
  dotnet build "${CRI_SDK_STAGE}/CriRuntime.csproj" --configuration Release --output "${CRI_SDK_STAGE}/Managed"
  cp -f "${CRI_SDK_STAGE}/Managed/CriMw.CriWare.Runtime.dll" "${MANAGED_IN}/"
  PATCH_ARGS+=(--cri-sdk-exports "${CRI_SDK_STAGE}/exports.txt")
fi
dotnet run --configuration Release --project "${ROOT_DIR}/tools/AssemblyPatcher/AssemblyPatcher.csproj" \
  -- "${PATCH_ARGS[@]}"

echo "[*] Running IL2CPP ahead-of-time compilation on patched assemblies..."
dotnet "${IL2CPP_DLL}" \
  --convert-to-cpp \
  --platform=iOS \
  --architecture=ARM64 \
  --dotnetprofile="unityaot-macos" \
  --directory="${MANAGED_IN}" \
  --generatedcppdir="${IL2CPP_OUT}" \
  --data-folder="${DATA_OUT}" \
  --configuration=Release \
  --emit-null-checks \
  --enable-array-bounds-check \
  --jobs=4

echo "[+] IL2CPP compilation complete! Generated C++ source and metadata."

# 4b. Locate and stage pch-cpp.hpp and pch-c.h and inject Unity version macros
echo "[*] Locating and staging pch-cpp.hpp and pch-c.h..."
PCH_SRC=""
if [[ -f "${IL2CPP_OUT}/pch-cpp.hpp" ]]; then
  PCH_SRC="${IL2CPP_OUT}/pch-cpp.hpp"
elif [[ -f "${XCODE_DIR}/Il2CppOutputProject/IL2CPP/libil2cpp/pch/pch-cpp.hpp" ]]; then
  PCH_SRC="${XCODE_DIR}/Il2CppOutputProject/IL2CPP/libil2cpp/pch/pch-cpp.hpp"
else
  PCH_SRC=$(find "${EXTRACT_DIR}" -name "pch-cpp.hpp" | head -n 1)
fi

if [[ -n "${PCH_SRC}" && -f "${PCH_SRC}" ]]; then
  echo "  -> Found pch-cpp.hpp at: ${PCH_SRC}"
  cp -f "${PCH_SRC}" "${XCODE_DIR}/Classes/pch-cpp.hpp"
  cp -f "${PCH_SRC}" "${IL2CPP_OUT}/pch-cpp.hpp" 2>/dev/null || true
else
  echo "[!] Creating default pch-cpp.hpp in Classes and IL2CPP output..."
  cat << 'EOF' > "${XCODE_DIR}/Classes/pch-cpp.hpp"
#pragma once
#include "il2cpp-config.h"
EOF
  cp -f "${XCODE_DIR}/Classes/pch-cpp.hpp" "${IL2CPP_OUT}/pch-cpp.hpp"
fi

PCH_C_SRC=""
if [[ -f "${IL2CPP_OUT}/pch-c.h" ]]; then
  PCH_C_SRC="${IL2CPP_OUT}/pch-c.h"
elif [[ -f "${XCODE_DIR}/Il2CppOutputProject/IL2CPP/libil2cpp/pch/pch-c.h" ]]; then
  PCH_C_SRC="${XCODE_DIR}/Il2CppOutputProject/IL2CPP/libil2cpp/pch/pch-c.h"
else
  PCH_C_SRC=$(find "${EXTRACT_DIR}" -name "pch-c.h" | head -n 1)
fi

if [[ -n "${PCH_C_SRC}" && -f "${PCH_C_SRC}" ]]; then
  echo "  -> Found pch-c.h at: ${PCH_C_SRC}"
  cp -f "${PCH_C_SRC}" "${XCODE_DIR}/Classes/pch-c.h"
  cp -f "${PCH_C_SRC}" "${IL2CPP_OUT}/pch-c.h" 2>/dev/null || true
else
  echo "[!] Creating default pch-c.h in Classes and IL2CPP output..."
  cat << 'EOF' > "${XCODE_DIR}/Classes/pch-c.h"
#pragma once
#include "il2cpp-config.h"
EOF
  cp -f "${XCODE_DIR}/Classes/pch-c.h" "${IL2CPP_OUT}/pch-c.h"
fi

echo "[*] Injecting Unity version and baselib macros into Prefix.pch, UnityTrampolineConfigure.h, and pch headers..."
cat << 'EOF' > /tmp/unity_version_prefix.h
#ifndef UNITY_VERSION_VER
#define UNITY_VERSION_VER 2022
#define UNITY_VERSION_MAJ 3
#define UNITY_VERSION_MIN 62
#endif
#ifndef BASELIB_INLINE_NAMESPACE
#define BASELIB_INLINE_NAMESPACE il2cpp_baselib
#endif
#ifndef RUNTIME_IL2CPP
#define RUNTIME_IL2CPP 1
#endif
EOF

for header in "${XCODE_DIR}/Classes/Prefix.pch" \
              "${XCODE_DIR}/Classes/UnityTrampolineConfigure.h" \
              "${XCODE_DIR}/Classes/pch-cpp.hpp" \
              "${IL2CPP_OUT}/pch-cpp.hpp" \
              "${XCODE_DIR}/Classes/pch-c.h" \
              "${IL2CPP_OUT}/pch-c.h" \
              "${XCODE_DIR}/Il2CppOutputProject/IL2CPP/libil2cpp/il2cpp-config.h" \
              "${XCODE_DIR}/Il2CppOutputProject/IL2CPP/libil2cpp/pch/pch-c.h" \
              "${XCODE_DIR}/Il2CppOutputProject/IL2CPP/libil2cpp/pch/pch-cpp.hpp"; do
  if [[ -f "${header}" ]]; then
    cat /tmp/unity_version_prefix.h "${header}" > "${header}.tmp" && mv "${header}.tmp" "${header}"
  fi
done

# 5. Copy converted game data into Data/
echo "[*] Installing converted game assets into Data/..."
cp -R "${ROOT_DIR}/ConvertedData/"* "${DATA_OUT}/"
# The iOS player resolves Application.streamingAssetsPath to Data/Raw.
mv "${DATA_OUT}/StreamingAssets" "${DATA_OUT}/Raw"
TEXTURE_OVERLAY="${AIC_TEXTURE_OVERLAY:-${XCODE_DIR}/TextureOverlay}"
if [[ ! -f "${TEXTURE_OVERLAY}/.complete" ]]; then
  python3 -m venv "${WORK_DIR}/texture-venv"
  "${WORK_DIR}/texture-venv/bin/python" -m pip install --disable-pip-version-check \
    -r "${ROOT_DIR}/tools/requirements-ios-textures.txt"
  "${WORK_DIR}/texture-venv/bin/python" "${ROOT_DIR}/tools/convert_assets.py" --repair-ios-textures \
    "${ROOT_DIR}/ConvertedData/StreamingAssets" "${TEXTURE_OVERLAY}"
fi
rsync -a --exclude=.complete "${TEXTURE_OVERLAY}/" "${DATA_OUT}/Raw/"
if [[ -n "${CRI_SDK_LIBRARY}" ]]; then
  cp "${CRI_SDK_STAGE}/CRI_ADX_LE_End_User_License_Agreement.txt" "${DATA_OUT}/Raw/"
fi
mkdir -p "${DATA_OUT}/Managed" "${DATA_OUT}/Managed/Metadata"
cp -f "${ROOT_DIR}/ConvertedData/RuntimeInitializeOnLoads.json" "${DATA_OUT}/Managed/" 2>/dev/null || true
cp -f "${ROOT_DIR}/ConvertedData/ScriptingAssemblies.json" "${DATA_OUT}/Managed/" 2>/dev/null || true
if [[ -f "${DATA_OUT}/Metadata/global-metadata.dat" ]]; then
  cp -f "${DATA_OUT}/Metadata/global-metadata.dat" "${DATA_OUT}/Managed/Metadata/"
fi

# 6. Compile native C plugins and engine registration stubs into static library
echo "[*] Compiling native plugins and engine registration stubs into static library..."
cp -f "${ROOT_DIR}/native/engine_stubs/RegisterMonoModules.cpp" "${XCODE_DIR}/Classes/RegisterMonoModules.cpp"

# Generate complete Unity internal call (icall) registration from libiPhone-lib.a
echo "[*] Generating Unity internal call registration from libiPhone-lib.a..."
python3 "${ROOT_DIR}/scripts/generate_icall_registration.py" \
  --lib "${LIB_IPHONE_SRC}" \
  --out "${XCODE_DIR}/Classes/UnityICallRegistration.cpp" \
  --verbose

SDK_PATH=$(xcrun --sdk iphoneos --show-sdk-path)
clang++ -c -O3 -arch arm64 -isysroot "${SDK_PATH}" -miphoneos-version-min=12.0 \
  -std=c++14 -fPIC \
  -DBASELIB_INLINE_NAMESPACE=il2cpp_baselib -DRUNTIME_IL2CPP=1 \
  "${XCODE_DIR}/Classes/RegisterMonoModules.cpp" -o RegisterMonoModules.o

clang++ -c -O3 -arch arm64 -isysroot "${SDK_PATH}" -miphoneos-version-min=12.0 \
  -std=c++14 -fPIC \
  "${XCODE_DIR}/Classes/UnityICallRegistration.cpp" -o UnityICallRegistration.o

clang -c -O3 -arch arm64 -isysroot "${SDK_PATH}" -miphoneos-version-min=12.0 \
  -I"${ROOT_DIR}/native/nanosockets" \
  "${ROOT_DIR}/native/nanosockets/nanosockets.c"

clang -c -O3 -arch arm64 -isysroot "${SDK_PATH}" -miphoneos-version-min=12.0 \
  -fobjc-arc "${ROOT_DIR}/native/ios/GameControllerBridge.m" -o GameControllerBridge.o

NATIVE_OBJECTS=(nanosockets.o RegisterMonoModules.o UnityICallRegistration.o GameControllerBridge.o)
if [[ -z "${CRI_SDK_LIBRARY}" ]]; then
  clang -c -O3 -arch arm64 -isysroot "${SDK_PATH}" -miphoneos-version-min=12.0 \
    -Wno-deprecated-non-prototype -Wno-strict-prototypes \
    "${ROOT_DIR}/native/criware_stub/cri_ware_stub.c"
  NATIVE_OBJECTS+=(cri_ware_stub.o)
fi
ar rcs "${XCODE_DIR}/Libraries/libNativePlugins.a" "${NATIVE_OBJECTS[@]}"
rm -f "${NATIVE_OBJECTS[@]}"

# 6b. Compile IL2CPP generated C++ sources and runtime into libGameAssembly.a
echo "[*] Preparing IL2CPP compilation and static library packaging..."
GAMEASSEMBLY_LIB="${XCODE_DIR}/Libraries/libGameAssembly.a"
OBJ_DIR="${WORK_DIR}/obj_gameassembly"
rm -rf "${OBJ_DIR}"
mkdir -p "${OBJ_DIR}" "${DERIVED_DATA}/Build/Products/Release-iphoneos"

if [[ "${AIC_USE_CCACHE:-0}" == 1 ]]; then
  AIC_CLANG=$(xcrun --sdk iphoneos --find clang)
  AIC_CLANGXX=$(xcrun --sdk iphoneos --find clang++)
  export AIC_CLANG AIC_CLANGXX
  ccache --zero-stats
fi

cat << 'EOF' > /tmp/compile_worker.sh
#!/usr/bin/env bash
set -e
obj_dir="$1"
sdk_path="$2"
xcode_dir="$3"
il2cpp_out="$4"
src="$5"

base_name=$(basename "${src}" | sed 's/\.[^.]*$//')
hash_val=$(echo "${src}" | cksum | cut -d' ' -f1)
obj="${obj_dir}/${base_name}_${hash_val}.o"

ext="${src##*.}"
if [[ "${ext}" == "c" ]]; then
  COMPILER="clang"
  CACHED_COMPILER="${AIC_CLANG:-}"
  STD_FLAG=""
else
  COMPILER="clang++"
  CACHED_COMPILER="${AIC_CLANGXX:-}"
  STD_FLAG="-std=c++14"
fi

if [[ "${AIC_USE_CCACHE:-0}" == 1 ]]; then
  compile=(ccache "${CACHED_COMPILER}")
else
  compile=(xcrun --sdk iphoneos "${COMPILER}")
fi

# Unchecked CIL integer arithmetic must wrap even when emitted as signed C++.
if ! "${compile[@]}" -c -Os -fwrapv -arch arm64 -isysroot "${sdk_path}" -miphoneos-version-min=12.0 \
  ${STD_FLAG} -fPIC -fexceptions -Wno-everything \
  -DUNITY_VERSION_VER=2022 -DUNITY_VERSION_MAJ=3 -DUNITY_VERSION_MIN=62 \
  -DBASELIB_INLINE_NAMESPACE=il2cpp_baselib \
  -DRUNTIME_IL2CPP=1 \
  -DNET_4_0 -DUNITY_AOT -DIL2CPP_TARGET_IOS=1 -DIL2CPP_ENABLE_ARM64=1 \
  -DGC_NOT_DLL -DALL_INTERIOR_POINTERS -DNO_EXECUTE_PERMISSION -DIL2CPP_ENABLE_WRITE_BARRIERS=1 \
  -I"${il2cpp_out}" \
  -I"${xcode_dir}/Classes" \
  -I"${xcode_dir}/Il2CppOutputProject/IL2CPP/libil2cpp" \
  -I"${xcode_dir}/Il2CppOutputProject/IL2CPP/libil2cpp/pch" \
  -I"${xcode_dir}/Il2CppOutputProject/IL2CPP/external/baselib/Include" \
  -I"${xcode_dir}/Il2CppOutputProject/IL2CPP/external/baselib/Platforms/OSX/Include" \
  -I"${xcode_dir}/Il2CppOutputProject/IL2CPP/external/baselib/Platforms/iOS/Include" \
  -I"${xcode_dir}/Il2CppOutputProject/IL2CPP/external/bdwgc/include" \
  -I"${xcode_dir}/Il2CppOutputProject/IL2CPP/external/xxHash" \
  -I"${xcode_dir}/Il2CppOutputProject/IL2CPP/libil2cpp/os/ClassLibraryPAL/brotli/include" \
  "${src}" -o "${obj}"; then
  echo "::error::Clang failed on ${src}"
  exit 255
fi
EOF
chmod +x /tmp/compile_worker.sh

NPROC=$(sysctl -n hw.ncpu 2>/dev/null || nproc 2>/dev/null || echo 4)

# Compile generated game logic C and C++ sources in parallel
echo "[*] Compiling generated game logic C/C++ sources in parallel using ${NPROC} workers..."
find "${IL2CPP_OUT}" -type f \( -name "*.cpp" -o -name "*.c" \) -print0 | \
  xargs -0 -P "${NPROC}" -n 1 /tmp/compile_worker.sh "${OBJ_DIR}" "${SDK_PATH}" "${XCODE_DIR}" "${IL2CPP_OUT}"

# Check for precompiled ARM64 libil2cpp or compile from source
echo "[*] Checking for precompiled ARM64 IL2CPP static libraries in Playback Engine..."
PRECOMPILED_IL2CPP=""
for cand in $(find "${EXTRACT_DIR}" -type f \( -name "libil2cpp*.a" -o -name "il2cpp*.a" \) 2>/dev/null | sort); do
  if [[ "${cand}" =~ sim|x64|x86 ]]; then
    continue
  fi
  if lipo -archs "${cand}" 2>/dev/null | grep -qw "arm64"; then
    if [[ ! "${cand}" =~ dev && ! "${cand}" =~ debug ]]; then
      PRECOMPILED_IL2CPP="${cand}"
      break
    elif [[ -z "${PRECOMPILED_IL2CPP}" ]]; then
      PRECOMPILED_IL2CPP="${cand}"
    fi
  fi
done

if [[ -n "${PRECOMPILED_IL2CPP}" && -f "${PRECOMPILED_IL2CPP}" ]]; then
  echo "[+] Found precompiled ARM64 IL2CPP runtime library: ${PRECOMPILED_IL2CPP}"
  cp -f "${PRECOMPILED_IL2CPP}" "${XCODE_DIR}/Libraries/libil2cpp.a"
else
  echo "[*] No precompiled ARM64 libil2cpp found. Compiling libil2cpp runtime from source into libGameAssembly.a..."
  IL2CPP_SRC_DIR="${XCODE_DIR}/Il2CppOutputProject/IL2CPP"
  find "${IL2CPP_SRC_DIR}/libil2cpp" -type f \( -name "*.cpp" -o -name "*.c" \) \
    ! -path "*/os/Win32/*" \
    ! -path "*/os/WindowsGames/*" \
    ! -path "*/os/Android/*" \
    ! -path "*/os/Lumin/*" \
    ! -path "*/os/Switch/*" \
    ! -path "*/os/XboxOne/*" \
    ! -path "*/os/PS4/*" \
    ! -path "*/os/PS5/*" \
    ! -path "*/os/Emscripten/*" \
    ! -path "*/os/QNX/*" \
    ! -path "*/os/WinRT/*" \
    ! -path "*/gc/null/*" \
    ! -path "*/gc/sgen/*" \
    ! -path "*/tests/*" \
    ! -name "main.cpp" \
    ! -name "main.c" \
    -print0 | \
    xargs -0 -P "${NPROC}" -n 1 /tmp/compile_worker.sh "${OBJ_DIR}" "${SDK_PATH}" "${XCODE_DIR}" "${IL2CPP_OUT}"

  # Also compile Boehm GC if present
  if [[ -f "${IL2CPP_SRC_DIR}/external/bdwgc/extra/gc.c" ]]; then
    echo "[*] Compiling Boehm GC (extra/gc.c)..."
    xcrun --sdk iphoneos clang -c -Os -arch arm64 -isysroot "${SDK_PATH}" -miphoneos-version-min=12.0 \
      -fPIC -fvisibility=hidden -Wno-everything \
      -DGC_NOT_DLL -DALL_INTERIOR_POINTERS -DNO_EXECUTE_PERMISSION \
      -I"${IL2CPP_SRC_DIR}/external/bdwgc" \
      -I"${IL2CPP_SRC_DIR}/external/bdwgc/include" \
      -I"${IL2CPP_SRC_DIR}/external/bdwgc/include/private" \
      -I"${IL2CPP_SRC_DIR}/external/bdwgc/src" \
      "${IL2CPP_SRC_DIR}/external/bdwgc/extra/gc.c" \
      -o "${OBJ_DIR}/bdwgc_gc.o"
  elif [[ -d "${IL2CPP_SRC_DIR}/external/bdwgc/src" ]]; then
    echo "[*] Compiling Boehm GC sources..."
    find "${IL2CPP_SRC_DIR}/external/bdwgc/src" -type f -name "*.c" \
      ! -name "win32_*.c" ! -name "wince_*.c" -print0 | \
      xargs -0 -P "${NPROC}" -n 1 /tmp/compile_worker.sh "${OBJ_DIR}" "${SDK_PATH}" "${XCODE_DIR}" "${IL2CPP_OUT}"
  fi

  # Also compile xxHash if present
  if [[ -f "${IL2CPP_SRC_DIR}/external/xxHash/xxhash.c" ]]; then
    echo "[*] Compiling xxHash..."
    xcrun --sdk iphoneos clang -c -Os -arch arm64 -isysroot "${SDK_PATH}" -miphoneos-version-min=12.0 \
      -fPIC -fvisibility=hidden -Wno-everything \
      -I"${IL2CPP_SRC_DIR}/external/xxHash" \
      "${IL2CPP_SRC_DIR}/external/xxHash/xxhash.c" \
      -o "${OBJ_DIR}/xxhash.o"
  fi
fi

if [[ "${AIC_USE_CCACHE:-0}" == 1 ]]; then
  ccache --show-stats
fi

NUM_OBJS=$(find "${OBJ_DIR}" -name "*.o" | wc -l | tr -d ' ')
echo "[*] Packaging ${NUM_OBJS} object files into ${GAMEASSEMBLY_LIB}..."
find "${OBJ_DIR}" -name "*.o" -print0 | xargs -0 ar rcs "${GAMEASSEMBLY_LIB}"
ranlib "${GAMEASSEMBLY_LIB}"
cp -f "${GAMEASSEMBLY_LIB}" "${DERIVED_DATA}/Build/Products/Release-iphoneos/libGameAssembly.a"
echo "[+] libGameAssembly.a created: $(ls -lh "${GAMEASSEMBLY_LIB}")"

# 7. Configure Info.plist for landscape and metadata
INFO_PLIST=$(find "${XCODE_DIR}" -name "Info.plist" | head -n 1)
if [[ -f "${INFO_PLIST}" ]]; then
  echo "[*] Configuring Info.plist for Alice in Cradle..."
  /usr/libexec/PlistBuddy -c "Set :CFBundleDisplayName 'Alice in Cradle'" "${INFO_PLIST}" 2>/dev/null || \
  /usr/libexec/PlistBuddy -c "Add :CFBundleDisplayName string 'Alice in Cradle'" "${INFO_PLIST}"
  
  /usr/libexec/PlistBuddy -c "Set :CFBundleName 'Alice in Cradle'" "${INFO_PLIST}" 2>/dev/null || \
  /usr/libexec/PlistBuddy -c "Add :CFBundleName string 'Alice in Cradle'" "${INFO_PLIST}"
  
  /usr/libexec/PlistBuddy -c "Set :CFBundleIdentifier 'com.NanameHacha.AliceInCradle'" "${INFO_PLIST}" 2>/dev/null || \
  /usr/libexec/PlistBuddy -c "Add :CFBundleIdentifier string 'com.NanameHacha.AliceInCradle'" "${INFO_PLIST}"
  
  /usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString '${GAME_VERSION}'" "${INFO_PLIST}" 2>/dev/null || \
  /usr/libexec/PlistBuddy -c "Add :CFBundleShortVersionString string '${GAME_VERSION}'" "${INFO_PLIST}"

  /usr/libexec/PlistBuddy -c "Set :UIRequiresFullScreen bool true" "${INFO_PLIST}" 2>/dev/null || \
  /usr/libexec/PlistBuddy -c "Add :UIRequiresFullScreen bool true" "${INFO_PLIST}"

  /usr/libexec/PlistBuddy -c "Set :UIStatusBarHidden bool true" "${INFO_PLIST}" 2>/dev/null || \
  /usr/libexec/PlistBuddy -c "Add :UIStatusBarHidden bool true" "${INFO_PLIST}"

  # Unity's iOS persistentDataPath is the app's Documents directory.
  for key in UIFileSharingEnabled LSSupportsOpeningDocumentsInPlace LSSupportsGameMode GCSupportsControllerUserInteraction; do
    /usr/libexec/PlistBuddy -c "Set :${key} true" "${INFO_PLIST}" 2>/dev/null ||
    /usr/libexec/PlistBuddy -c "Add :${key} bool true" "${INFO_PLIST}"
  done

  /usr/libexec/PlistBuddy -c "Delete :UISupportedInterfaceOrientations" "${INFO_PLIST}" 2>/dev/null || true
  /usr/libexec/PlistBuddy -c "Add :UISupportedInterfaceOrientations array" "${INFO_PLIST}" 2>/dev/null || true
  /usr/libexec/PlistBuddy -c "Add :UISupportedInterfaceOrientations:0 string UIInterfaceOrientationLandscapeRight" "${INFO_PLIST}" 2>/dev/null || true
  /usr/libexec/PlistBuddy -c "Add :UISupportedInterfaceOrientations:1 string UIInterfaceOrientationLandscapeLeft" "${INFO_PLIST}" 2>/dev/null || true
fi

# 7b. Create the AppIcon asset catalog from the supplied artwork
echo "[*] Preparing the Alice in Cradle AppIcon asset catalog..."
ICON_SOURCE="${ROOT_DIR}/resources/icon/AIC_icon_512x512.png"
ICON_PNG="${XCODE_DIR}/Icon-1024.png"
sips -z 1024 1024 "${ICON_SOURCE}" --out "${ICON_PNG}"
XCODE_DIR="${XCODE_DIR}" ICON_PNG="${ICON_PNG}" python3 - << 'PYEOF'
import os
import shutil

xcode_dir = os.environ["XCODE_DIR"]

for rel in ["Unity-iPhone/Images.xcassets", "Images.xcassets"]:
    assets_dir = os.path.join(xcode_dir, rel)
    iconset_dir = os.path.join(assets_dir, "AppIcon.appiconset")
    os.makedirs(iconset_dir, exist_ok=True)
    
    with open(os.path.join(assets_dir, "Contents.json"), "w") as f:
        f.write('{"info":{"author":"xcode","version":1}}\n')
        
    with open(os.path.join(iconset_dir, "Contents.json"), "w") as f:
        f.write('''{
  "images" : [
    {
      "filename" : "Icon-1024.png",
      "idiom" : "universal",
      "platform" : "ios",
      "size" : "1024x1024"
    }
  ],
  "info" : {
    "author" : "xcode",
    "version" : 1
  }
}''')
    
    shutil.copyfile(os.environ["ICON_PNG"], os.path.join(iconset_dir, "Icon-1024.png"))
    print(f"[+] Created AppIcon in {iconset_dir}")
PYEOF

# 7c. Inspect and patch Xcode project build settings
echo "[*] Inspecting and patching Xcode project build settings..."
XCODE_DIR="${XCODE_DIR}" python3 - << 'PYEOF'
import os, re

xcode_dir = os.environ.get("XCODE_DIR", "")
pbx_path = os.path.join(xcode_dir, "Unity-iPhone.xcodeproj", "project.pbxproj")

if os.path.exists(pbx_path):
    with open(pbx_path, "r", encoding="utf-8") as f:
        content = f.read()

    print(f"[*] Read {pbx_path} ({len(content)} bytes)")

    # Inject version macros and disable bitcode/signing into all buildSettings blocks
    version_block = """buildSettings = {
				UNITY_VERSION_VER = 2022;
				UNITY_VERSION_MAJ = 3;
				UNITY_VERSION_MIN = 62;
				BASELIB_INLINE_NAMESPACE = il2cpp_baselib;
				RUNTIME_IL2CPP = 1;
				ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
				ENABLE_BITCODE = NO;
				CODE_SIGNING_ALLOWED = NO;
				CODE_SIGNING_REQUIRED = NO;
				LIBRARY_SEARCH_PATHS = (
					"$(inherited)",
					"$(SRCROOT)/Libraries",
					"$(PROJECT_DIR)/Libraries",
				);"""
    content = content.replace("buildSettings = {", version_block)

    with open(pbx_path, "w", encoding="utf-8") as f:
        f.write(content)
    print("[+] Successfully patched project.pbxproj with version macros and build settings.")
PYEOF

# 8. Build with xcodebuild
echo "[*] Available schemes in Xcode project:"
xcodebuild -list -project "${XCODE_DIR}/Unity-iPhone.xcodeproj" || true

echo "[*] Building Xcode project with xcodebuild (target: iphoneos)..."

# Collect all IL2CPP include directories
IL2CPP_INCS=$(find "${XCODE_DIR}/Il2CppOutputProject/IL2CPP" -type d \( -name "Include" -o -name "include" -o -name "libil2cpp" -o -name "pch" \) 2>/dev/null | tr '\n' ' ')

LDFLAGS_EXTRA="-force_load ${XCODE_DIR}/Libraries/libNativePlugins.a -framework GameController"
if [[ -n "${CRI_SDK_LIBRARY}" ]]; then
  LDFLAGS_EXTRA="${LDFLAGS_EXTRA} -force_load ${CRI_SDK_LIBRARY} -framework UIKit -framework AVFoundation -framework AudioToolbox -framework CoreAudio -framework CFNetwork"
fi
if [[ -f "${GAMEASSEMBLY_LIB}" ]]; then
  LDFLAGS_EXTRA="${LDFLAGS_EXTRA} -force_load ${GAMEASSEMBLY_LIB}"
fi
if [[ -f "${XCODE_DIR}/Libraries/libil2cpp.a" ]]; then
  LDFLAGS_EXTRA="${LDFLAGS_EXTRA} -force_load ${XCODE_DIR}/Libraries/libil2cpp.a"
fi

xcodebuild -project "${XCODE_DIR}/Unity-iPhone.xcodeproj" \
  -scheme Unity-iPhone \
  -sdk iphoneos \
  -configuration Release \
  -derivedDataPath "${DERIVED_DATA}" \
  GCC_PREPROCESSOR_DEFINITIONS="\$(inherited) UNITY_VERSION_VER=2022 UNITY_VERSION_MAJ=3 UNITY_VERSION_MIN=62 BASELIB_INLINE_NAMESPACE=il2cpp_baselib RUNTIME_IL2CPP=1" \
  HEADER_SEARCH_PATHS="\$(inherited) ${XCODE_DIR}/Classes ${IL2CPP_OUT} ${IL2CPP_INCS}" \
  USER_HEADER_SEARCH_PATHS="\$(inherited) ${XCODE_DIR}/Classes ${IL2CPP_OUT} ${IL2CPP_INCS}" \
  LIBRARY_SEARCH_PATHS="\$(inherited) ${XCODE_DIR}/Libraries ${DERIVED_DATA}/Build/Products/Release-iphoneos" \
  OTHER_LDFLAGS="\$(inherited) ${LDFLAGS_EXTRA}" \
  ASSETCATALOG_COMPILER_APPICON_NAME="AppIcon" \
  CODE_SIGNING_ALLOWED=NO \
  CODE_SIGNING_REQUIRED=NO \
  CODE_SIGN_IDENTITY="" \
  build

# 9. Package into unsigned IPA
PRODUCTS_DIR="${DERIVED_DATA}/Build/Products/Release-iphoneos"
APP_BUNDLE=$(find "${PRODUCTS_DIR}" -maxdepth 1 -name "*.app" 2>/dev/null | head -n 1)

if [[ -z "${APP_BUNDLE}" ]]; then
  echo "[!] .app bundle not found in ${PRODUCTS_DIR}, searching whole DerivedData..."
  APP_BUNDLE=$(find "${DERIVED_DATA}" -name "*.app" | head -n 1)
fi

if [[ -z "${APP_BUNDLE}" ]]; then
  echo "::error::Compiled .app bundle not found in ${PRODUCTS_DIR}"
  exit 1
fi

echo "[*] Packaging .app into IPA payload: ${APP_BUNDLE}"
PAYLOAD_DIR="${WORK_DIR}/Payload"
rm -rf "${PAYLOAD_DIR}"
mkdir -p "${PAYLOAD_DIR}"
cp -R "${APP_BUNDLE}" "${PAYLOAD_DIR}/Alice in Cradle.app"

BUNDLE_PLIST="${PAYLOAD_DIR}/Alice in Cradle.app/Info.plist"
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion ${BUILD_VERSION}" "${BUNDLE_PLIST}" 2>/dev/null ||
/usr/libexec/PlistBuddy -c "Add :CFBundleVersion string ${BUILD_VERSION}" "${BUNDLE_PLIST}"

# 9b. Patch UnityFramework build target platform checks dynamically
echo "[*] Applying runtime compatibility patches to UnityFramework..."
PAYLOAD_DIR="${PAYLOAD_DIR}" python3 - << 'PYEOF'
import os, glob

app_dir = os.path.join(os.environ.get("PAYLOAD_DIR", "/tmp/aic_ios_build/Payload"), "Alice in Cradle.app")
uf_paths = glob.glob(f"{app_dir}/**/UnityFramework", recursive=True)
for uf_path in uf_paths:
    if os.path.isfile(uf_path) and not os.path.islink(uf_path):
        print(f"  Checking {uf_path}...")
        with open(uf_path, "rb") as f:
            data = bytearray(f.read())
        pat1 = bytes.fromhex("5f250071")
        pat2 = bytes.fromhex("0c20a1527f010c6b")
        pos2 = data.find(pat2)
        if pos2 != -1:
            pos1 = data.rfind(pat1, 0, pos2)
            if pos1 != -1 and (pos2 - pos1) < 0x2000:
                nop = bytes.fromhex("1f2003d5")
                data[pos1+4:pos1+8] = nop
                data[pos2+8:pos2+12] = nop
                with open(uf_path, "wb") as f:
                    f.write(data)
                print(f"[+] Successfully patched UnityFramework platform checks at 0x{pos1+4:x} and 0x{pos2+8:x}!")
            else:
                print(f"[!] Warning: pat1 not found within 8KB before pat2 (pos2=0x{pos2:x})")
        else:
            print(f"[!] Warning: pat2 not found in {uf_path}")
PYEOF

# Ensure Data directory is inside .app bundle with all converted assets
echo "[*] Ensuring all game Data assets are inside Alice in Cradle.app bundle..."
mkdir -p "${PAYLOAD_DIR}/Alice in Cradle.app/Data"
cp -R "${DATA_OUT}/"* "${PAYLOAD_DIR}/Alice in Cradle.app/Data/"

IPA_NAME="${ARTIFACT_NAME}_Unsigned.ipa"
IPA_PATH="${OUTPUT_DIR}/${IPA_NAME}"
(cd "${WORK_DIR}" && zip -r -9 "${IPA_PATH}" Payload)

if [[ -n "${GITHUB_OUTPUT:-}" ]]; then
  printf 'artifact_name=%s\nipa_path=%s\n' "${ARTIFACT_NAME}" "${IPA_PATH}" >> "${GITHUB_OUTPUT}"
fi

echo "================================================================="
echo "[+] SUCCESS! iOS IPA Package created (build ${BUILD_VERSION}):"
echo "    ${IPA_PATH}"
echo "    Size: $(du -h "${IPA_PATH}" | cut -f1)"
echo "================================================================="
