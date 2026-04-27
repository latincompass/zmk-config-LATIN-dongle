#!/bin/bash

# Building LATIN for Xiao BLE (单端键盘模式)
set -e # stop on error

# Paths
PROJECT_DIR="$HOME/Documents/zmk-config-LATIN"
DOWNLOADS_DIR="$HOME/Downloads"
ZEPHYR_SDK="$HOME/.opt/zephyr-sdk-0.17.4"

# File Names (修复原脚本变量名错误)
LATIN_FIRMWARE="LATIN-seeeduino_xiao_ble-zmk_local-build.uf2"

echo "=== Building LATIN Single Firmware ==="

cd "$PROJECT_DIR"

# Old builds cleanup
echo "Old builds cleanup..."
rm -rf build-LATIN

# Environment setup
export ZEPHYR_BASE="$PWD/zephyr"
export ZEPHYR_SDK_INSTALL_DIR="$ZEPHYR_SDK"
export ZEPHYR_TOOLCHAIN_VARIANT=zephyr

# Registering Zephyr in CMake
echo "Registering Zephyr..."
west zephyr-export

# 单端键盘编译（禁用分体模式）
echo ""
echo ">>> Building single keyboard..."
west build -p -b seeeduino_xiao_ble -d build-LATIN -s zmk/app -- \
  -DSHIELD=LATIN \
  -DZMK_CONFIG="$PWD/config" \
  -DZMK_SPLIT=0  # 强制禁用分体模式

# Copy artefacts into Downloads folder
echo ""
echo ">>> Copying files into Downloads folder..."

cp "build-LATIN/zephyr/zmk.uf2" "$DOWNLOADS_DIR/$LATIN_FIRMWARE"
echo "✓ Single firmware: $DOWNLOADS_DIR/$LATIN_FIRMWARE"

echo ""
echo "=== Done! ==="
echo "Firmware saved into $DOWNLOADS_DIR"