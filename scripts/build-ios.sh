#!/usr/bin/env bash
set -euo pipefail

echo "================================================================="
echo "   Alice in Cradle (iOS Port) - Automated macOS Builder         "
echo "================================================================="

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WORK_DIR="/tmp/aic_ios_build"
OUTPUT_DIR="${ROOT_DIR}/artifacts"
DERIVED_DATA="${WORK_DIR}/DerivedData"
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
mkdir -p "${IL2CPP_OUT}" "${DATA_OUT}"

echo "[*] Running IL2CPP ahead-of-time compilation on patched assemblies..."
dotnet "${IL2CPP_DLL}" \
  --convert-to-cpp \
  --platform=iOS \
  --architecture=ARM64 \
  --dotnetprofile="unityaot-macos" \
  --directory="${ROOT_DIR}/PatchedManaged" \
  --generatedcppdir="${IL2CPP_OUT}" \
  --data-folder="${DATA_OUT}" \
  --configuration=Release \
  --emit-null-checks \
  --enable-array-bounds-check \
  --jobs=4

echo "[+] IL2CPP compilation complete! Generated C++ source and metadata."

# 4b. Locate and stage pch-cpp.hpp and inject Unity version macros
echo "[*] Locating and staging pch-cpp.hpp..."
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
              "${XCODE_DIR}/Il2CppOutputProject/IL2CPP/libil2cpp/il2cpp-config.h" \
              "${XCODE_DIR}/Il2CppOutputProject/IL2CPP/libil2cpp/pch/pch-cpp.hpp"; do
  if [[ -f "${header}" ]]; then
    cat /tmp/unity_version_prefix.h "${header}" > "${header}.tmp" && mv "${header}.tmp" "${header}"
  fi
done

# 5. Copy converted game data into Data/
echo "[*] Installing converted game assets into Data/..."
cp -R "${ROOT_DIR}/ConvertedData/"* "${DATA_OUT}/"
mkdir -p "${DATA_OUT}/Managed" "${DATA_OUT}/Managed/Metadata"
cp -f "${ROOT_DIR}/ConvertedData/RuntimeInitializeOnLoads.json" "${DATA_OUT}/Managed/" 2>/dev/null || true
cp -f "${ROOT_DIR}/ConvertedData/ScriptingAssemblies.json" "${DATA_OUT}/Managed/" 2>/dev/null || true
if [[ -f "${DATA_OUT}/Metadata/global-metadata.dat" ]]; then
  cp -f "${DATA_OUT}/Metadata/global-metadata.dat" "${DATA_OUT}/Managed/Metadata/"
fi

# 6. Compile native C plugins and engine registration stubs into static library
echo "[*] Compiling native plugins and engine registration stubs into static library..."
cat << 'EOF' > "${XCODE_DIR}/Classes/RegisterMonoModules.cpp"
#include <stddef.h>
#include <stdint.h>
#include <dlfcn.h>
#include <sched.h>
#include <pthread.h>
#include <mach/mach.h>
#include <mach/semaphore.h>

// Unity Engine Class & Module Registration Stubs for IL2CPP
void RegisterAllClasses() {}
void RegisterAllStrippedInternalCalls() {}
extern "C" void RegisterStaticallyLinkedModulesGranular() {}
void InvokeRegisterStaticallyLinkedModuleClasses() {}

// Fallback for IL2CPP Codegen Registration symbol
typedef void (*CodegenRegistrationFunction)();
extern "C" {
    __attribute__((weak)) void s_Il2CppCodegenRegistration_Fallback() {}
    __attribute__((weak)) CodegenRegistrationFunction g_CodegenRegistration = s_Il2CppCodegenRegistration_Fallback;
}

// Baselib Posix / Darwin Implementation Stubs under il2cpp_baselib namespace
namespace il2cpp_baselib {

struct Baselib_DynamicLibrary_Handle {
    uintptr_t handle;
};

struct Baselib_SystemSemaphore_Handle {
    uintptr_t handle;
};

typedef uint64_t Baselib_Thread_Id;

void Baselib_DynamicLibrary_Close(Baselib_DynamicLibrary_Handle handle) {
    if (handle.handle != 0) {
        ::dlclose((void*)handle.handle);
    }
}

void Baselib_Thread_YieldExecution() {
    sched_yield();
}

Baselib_Thread_Id Baselib_Thread_GetCurrentThreadId() {
    uint64_t tid = 0;
    pthread_threadid_np(NULL, &tid);
    return tid;
}

Baselib_SystemSemaphore_Handle Baselib_SystemSemaphore_CreateInplace(void* memoryBlock) {
    semaphore_t sem = 0;
    kern_return_t ret = semaphore_create(mach_task_self(), &sem, SYNC_POLICY_FIFO, 0);
    Baselib_SystemSemaphore_Handle handle;
    handle.handle = (ret == KERN_SUCCESS) ? (uintptr_t)sem : 0;
    if (memoryBlock) {
        *(Baselib_SystemSemaphore_Handle*)memoryBlock = handle;
    }
    return handle;
}

void Baselib_SystemSemaphore_Acquire(Baselib_SystemSemaphore_Handle handle) {
    if (handle.handle != 0) {
        semaphore_wait((semaphore_t)handle.handle);
    }
}

bool Baselib_SystemSemaphore_TryAcquire(Baselib_SystemSemaphore_Handle handle) {
    if (handle.handle == 0) return false;
    mach_timespec_t ts = {0, 0};
    kern_return_t ret = semaphore_timedwait((semaphore_t)handle.handle, ts);
    return (ret == KERN_SUCCESS);
}

bool Baselib_SystemSemaphore_TryTimedAcquire(Baselib_SystemSemaphore_Handle handle, unsigned int timeoutInMilliseconds) {
    if (handle.handle == 0) return false;
    mach_timespec_t ts;
    ts.tv_sec = timeoutInMilliseconds / 1000;
    ts.tv_nsec = (clock_res_t)((timeoutInMilliseconds % 1000) * 1000000);
    kern_return_t ret = semaphore_timedwait((semaphore_t)handle.handle, ts);
    return (ret == KERN_SUCCESS);
}

void Baselib_SystemSemaphore_Release(Baselib_SystemSemaphore_Handle handle, unsigned int count) {
    if (handle.handle != 0) {
        for (unsigned int i = 0; i < count; ++i) {
            semaphore_signal((semaphore_t)handle.handle);
        }
    }
}

void Baselib_SystemSemaphore_FreeInplace(Baselib_SystemSemaphore_Handle handle) {
    if (handle.handle != 0) {
        semaphore_destroy(mach_task_self(), (semaphore_t)handle.handle);
    }
}

} // namespace il2cpp_baselib
EOF

SDK_PATH=$(xcrun --sdk iphoneos --show-sdk-path)
clang++ -c -O3 -arch arm64 -isysroot "${SDK_PATH}" -miphoneos-version-min=12.0 \
  -std=c++14 -fPIC \
  -DBASELIB_INLINE_NAMESPACE=il2cpp_baselib -DRUNTIME_IL2CPP=1 \
  "${XCODE_DIR}/Classes/RegisterMonoModules.cpp" -o RegisterMonoModules.o

clang -c -O3 -arch arm64 -isysroot "${SDK_PATH}" -miphoneos-version-min=12.0 \
  -Wno-deprecated-non-prototype -Wno-strict-prototypes \
  -I"${ROOT_DIR}/native/nanosockets" \
  "${ROOT_DIR}/native/nanosockets/nanosockets.c" \
  "${ROOT_DIR}/native/criware_stub/cri_ware_stub.c"

ar rcs "${XCODE_DIR}/Libraries/libNativePlugins.a" nanosockets.o cri_ware_stub.o RegisterMonoModules.o
rm -f nanosockets.o cri_ware_stub.o RegisterMonoModules.o

# 6b. Compile IL2CPP generated C++ sources and runtime into libGameAssembly.a
echo "[*] Preparing IL2CPP compilation and static library packaging..."
GAMEASSEMBLY_LIB="${XCODE_DIR}/Libraries/libGameAssembly.a"
OBJ_DIR="${WORK_DIR}/obj_gameassembly"
rm -rf "${OBJ_DIR}"
mkdir -p "${OBJ_DIR}" "${DERIVED_DATA}/Build/Products/Release-iphoneos"

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
  STD_FLAG=""
else
  COMPILER="clang++"
  STD_FLAG="-std=c++14"
fi

if ! xcrun --sdk iphoneos ${COMPILER} -c -Os -arch arm64 -isysroot "${sdk_path}" -miphoneos-version-min=12.0 \
  ${STD_FLAG} -fPIC -fvisibility=hidden -fexceptions -Wno-everything \
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

# Compile generated game logic C++ sources in parallel
echo "[*] Compiling generated game logic C++ sources in parallel using ${NPROC} workers..."
find "${IL2CPP_OUT}" -name "*.cpp" -print0 | \
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
  (cd "${OBJ_DIR}" && ar -x "${PRECOMPILED_IL2CPP}")
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
  
  /usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString '0.30i'" "${INFO_PLIST}" 2>/dev/null || \
  /usr/libexec/PlistBuddy -c "Add :CFBundleShortVersionString string '0.30i'" "${INFO_PLIST}"

  /usr/libexec/PlistBuddy -c "Set :UIRequiresFullScreen bool true" "${INFO_PLIST}" 2>/dev/null || \
  /usr/libexec/PlistBuddy -c "Add :UIRequiresFullScreen bool true" "${INFO_PLIST}"

  /usr/libexec/PlistBuddy -c "Set :UIStatusBarHidden bool true" "${INFO_PLIST}" 2>/dev/null || \
  /usr/libexec/PlistBuddy -c "Add :UIStatusBarHidden bool true" "${INFO_PLIST}"

  /usr/libexec/PlistBuddy -c "Delete :UISupportedInterfaceOrientations" "${INFO_PLIST}" 2>/dev/null || true
  /usr/libexec/PlistBuddy -c "Add :UISupportedInterfaceOrientations array" "${INFO_PLIST}" 2>/dev/null || true
  /usr/libexec/PlistBuddy -c "Add :UISupportedInterfaceOrientations:0 string UIInterfaceOrientationLandscapeRight" "${INFO_PLIST}" 2>/dev/null || true
  /usr/libexec/PlistBuddy -c "Add :UISupportedInterfaceOrientations:1 string UIInterfaceOrientationLandscapeLeft" "${INFO_PLIST}" 2>/dev/null || true
fi

# 7b. Generate default AppIcon and Images.xcassets catalog
echo "[*] Generating default AppIcon asset catalog for Alice in Cradle..."
XCODE_DIR="${XCODE_DIR}" python3 - << 'PYEOF'
import os, struct, zlib

def create_png(width, height, color):
    r, g, b = color
    raw_row = bytes([0] + [r, g, b] * width)
    compressed = zlib.compress(raw_row * height)
    png = b'\x89PNG\r\n\x1a\n'
    ihdr_data = struct.pack('>IIBBBBB', width, height, 8, 2, 0, 0, 0)
    ihdr_crc = zlib.crc32(b'IHDR' + ihdr_data)
    png += struct.pack('>I', len(ihdr_data)) + b'IHDR' + ihdr_data + struct.pack('>I', ihdr_crc)
    idat_crc = zlib.crc32(b'IDAT' + compressed)
    png += struct.pack('>I', len(compressed)) + b'IDAT' + compressed + struct.pack('>I', idat_crc)
    iend_crc = zlib.crc32(b'IEND')
    png += struct.pack('>I', 0) + b'IEND' + struct.pack('>I', iend_crc)
    return png

xcode_dir = os.environ.get("XCODE_DIR", "")
icon_png = create_png(1024, 1024, (244, 143, 177))

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
    
    with open(os.path.join(iconset_dir, "Icon-1024.png"), "wb") as f:
        f.write(icon_png)
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

LDFLAGS_EXTRA="-force_load ${XCODE_DIR}/Libraries/libNativePlugins.a"
if [[ -f "${XCODE_DIR}/Libraries/libil2cpp.a" ]]; then
  LDFLAGS_EXTRA="${LDFLAGS_EXTRA} ${XCODE_DIR}/Libraries/libil2cpp.a"
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

# Ensure Data directory is inside .app bundle with all converted assets
echo "[*] Ensuring all game Data assets are inside Alice in Cradle.app bundle..."
mkdir -p "${PAYLOAD_DIR}/Alice in Cradle.app/Data"
cp -R "${DATA_OUT}/"* "${PAYLOAD_DIR}/Alice in Cradle.app/Data/"

IPA_NAME="AliceInCradle_v0.30i_iOS_Unsigned.ipa"
IPA_PATH="${OUTPUT_DIR}/${IPA_NAME}"
(cd "${WORK_DIR}" && zip -r -9 "${IPA_PATH}" Payload)

echo "================================================================="
echo "[+] SUCCESS! iOS IPA Package created:"
echo "    ${IPA_PATH}"
echo "    Size: $(du -h "${IPA_PATH}" | cut -f1)"
echo "================================================================="
