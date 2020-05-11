#!/usr/bin/env bash
set -e
publish_dir="${1:-publish}"

mkdir -p "$publish_dir"

# Build
./scripts/build_msys2.sh Release

# Copy build artifacts
cp build/MotorolaFlash.exe "$publish_dir/MotorolaFlash.exe"
cp ThirdParty/fastboot/android_development/host/windows/prebuilt/usb/AdbWinUsbApi.dll \
    "$publish_dir/AdbWinUsbApi.dll"

# Bundle dependencies
./scripts/bundle_dlls.sh "$publish_dir/" "$publish_dir/MotorolaFlash.exe" "/mingw32/bin"

# Ship Qt
windeployqt "$publish_dir/MotorolaFlash.exe" "$publish_dir"