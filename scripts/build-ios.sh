#!/usr/bin/env bash
set -euo pipefail

echo "================================================================="
echo "   Alice in Cradle (iOS Port) - Automated macOS Builder         "
echo "================================================================="

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WORK_DIR="/tmp/aic_ios_build"
OUTPUT_DIR="${ROOT_DIR}/artifacts"
mkdir -p "${WORK_DIR}" "${OUTPUT_DIR}"

UNITY_VERSION="2022.3.62f2"
CHANGESET="7670c08855a9"
PKG_URL="https://download.unity3d.com/download_unity/${CHANGESET}/MacEditorTargetInstaller/UnitySetup-iOS-Support-for-Editor-${UNITY_VERSION}.pkg"

echo "[*] Working directory: ${WORK_DIR}"
echo "[*] Target Unity version: ${UNITY_VERSION} (${CHANGESET})"

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

# 2. Locate components inside Playback Engine
echo "[*] Locating Trampoline, IL2CPP compiler, and iOS runtime..."
TRAMPOLINE_SRC=$(find "${EXTRACT_DIR}" -type d -name "Trampoline" | head -n 1)
LIB_IPHONE_SRC=$(find "${EXTRACT_DIR}" -type f -name "libiPhone-lib.a" | head -n 1)
IL2CPP_DLL=$(find "${EXTRACT_DIR}" -type f -name "il2cpp.dll" | head -n 1)

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

# 4. Run IL2CPP on PatchedManaged assemblies
IL2CPP_OUT="${XCODE_DIR}/Il2CppOutputProject/Source/il2cppOutput"
DATA_OUT="${XCODE_DIR}/Data"
mkdir -p "${IL2CPP_OUT}" "${DATA_OUT}"

echo "[*] Running IL2CPP ahead-of-time compilation on patched assemblies..."
dotnet "${IL2CPP_DLL}" \
  --convert-to-cpp \
  --dotnetprofile="unityaot-ios" \
  --directory="${ROOT_DIR}/PatchedManaged" \
  --generatedcppdir="${IL2CPP_OUT}" \
  --data-folder="${DATA_OUT}" \
  --configuration=Release \
  --emit-null-checks \
  --enable-array-bounds-check \
  --jobs=4

echo "[+] IL2CPP compilation complete! Generated C++ source and metadata."

# 5. Copy converted game data into Data/
echo "[*] Installing converted game assets into Data/..."
cp -R "${ROOT_DIR}/ConvertedData/"* "${DATA_OUT}/"

# 6. Compile native C plugins (NanoSockets & CRIWARE stub) into static library
echo "[*] Compiling native plugins (NanoSockets & CRIWARE stub) into static library..."
SDK_PATH=$(xcrun --sdk iphoneos --show-sdk-path)
clang -c -O3 -arch arm64 -isysroot "${SDK_PATH}" -miphoneos-version-min=12.0 \
  -I"${ROOT_DIR}/native/nanosockets" \
  "${ROOT_DIR}/native/nanosockets/nanosockets.c" \
  "${ROOT_DIR}/native/criware_stub/cri_ware_stub.c"

ar rcs "${XCODE_DIR}/Libraries/libNativePlugins.a" nanosockets.o cri_ware_stub.o
rm -f nanosockets.o cri_ware_stub.o

# 7. Configure Info.plist for landscape and metadata
INFO_PLIST=$(find "${XCODE_DIR}" -name "Info.plist" | head -n 1)
if [[ -f "${INFO_PLIST}" ]]; then
  echo "[*] Configuring Info.plist for Alice in Cradle..."
  /usr/libexec/PlistBuddy -c "Set :CFBundleDisplayName 'Alice in Cradle'" "${INFO_PLIST}" 2>/dev/null || \
  /usr/libexec/PlistBuddy -c "Add :CFBundleDisplayName string 'Alice in Cradle'" "${INFO_PLIST}"
  
  /usr/libexec/PlistBuddy -c "Set :CFBundleIdentifier 'com.NanameHacha.AliceInCradle'" "${INFO_PLIST}" 2>/dev/null || \
  /usr/libexec/PlistBuddy -c "Add :CFBundleIdentifier string 'com.NanameHacha.AliceInCradle'" "${INFO_PLIST}"
  
  /usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString '0.30i'" "${INFO_PLIST}" 2>/dev/null || \
  /usr/libexec/PlistBuddy -c "Add :CFBundleShortVersionString string '0.30i'" "${INFO_PLIST}"

  /usr/libexec/PlistBuddy -c "Set :UIRequiresFullScreen bool true" "${INFO_PLIST}" 2>/dev/null || \
  /usr/libexec/PlistBuddy -c "Add :UIRequiresFullScreen bool true" "${INFO_PLIST}"

  /usr/libexec/PlistBuddy -c "Set :UIStatusBarHidden bool true" "${INFO_PLIST}" 2>/dev/null || \
  /usr/libexec/PlistBuddy -c "Add :UIStatusBarHidden bool true" "${INFO_PLIST}"
fi

# 8. Build with xcodebuild
echo "[*] Building Xcode project with xcodebuild (target: iphoneos)..."
DERIVED_DATA="${WORK_DIR}/DerivedData"

xcodebuild -project "${XCODE_DIR}/Unity-iPhone.xcodeproj" \
  -scheme Unity-iPhone \
  -sdk iphoneos \
  -configuration Release \
  -derivedDataPath "${DERIVED_DATA}" \
  OTHER_LDFLAGS="\$(inherited) -force_load ${XCODE_DIR}/Libraries/libNativePlugins.a" \
  CODE_SIGNING_ALLOWED=NO \
  CODE_SIGNING_REQUIRED=NO \
  CODE_SIGN_IDENTITY="" \
  build

# 9. Package into unsigned IPA
PRODUCTS_DIR="${DERIVED_DATA}/Build/Products/Release-iphoneos"
APP_BUNDLE=$(find "${PRODUCTS_DIR}" -maxdepth 1 -name "*.app" | head -n 1)

if [[ -z "${APP_BUNDLE}" ]]; then
  echo "::error::Compiled .app bundle not found in ${PRODUCTS_DIR}"
  exit 1
fi

echo "[*] Packaging .app into IPA payload: ${APP_BUNDLE}"
PAYLOAD_DIR="${WORK_DIR}/Payload"
rm -rf "${PAYLOAD_DIR}"
mkdir -p "${PAYLOAD_DIR}"
cp -R "${APP_BUNDLE}" "${PAYLOAD_DIR}/"

IPA_NAME="AliceInCradle_v0.30i_iOS_Unsigned.ipa"
IPA_PATH="${OUTPUT_DIR}/${IPA_NAME}"
(cd "${WORK_DIR}" && zip -r -9 "${IPA_PATH}" Payload)

echo "================================================================="
echo "[+] SUCCESS! iOS IPA Package created:"
echo "    ${IPA_PATH}"
echo "    Size: $(du -h "${IPA_PATH}" | cut -f1)"
echo "================================================================="
