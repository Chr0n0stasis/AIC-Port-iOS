#!/usr/bin/env bash
set -euo pipefail

if [[ $# != 2 ]]; then
  echo "Usage: bash scripts/build-xcode.sh <Unity-iPhone.xcodeproj> <output.zip>" >&2
  exit 2
fi

project="$1"
output="$2"
[[ -d "$project" ]] || { echo "Xcode project not found: $project" >&2; exit 1; }
work="$(mktemp -d)"
echo "Xcode build output: $work"
xcodebuild -project "$project" -scheme Unity-iPhone -sdk iphoneos \
  -configuration Release -derivedDataPath "$work" \
  CODE_SIGNING_ALLOWED=NO CODE_SIGNING_REQUIRED=NO build

products="$work/Build/Products/Release-iphoneos"
app="$(find "$products" -maxdepth 1 -type d -name '*.app' -print -quit)"
[[ -n "$app" ]] || { echo "No device app found in $products" >&2; exit 1; }
mkdir -p "$(dirname "$output")"
ditto -c -k --keepParent "$app" "$output"
