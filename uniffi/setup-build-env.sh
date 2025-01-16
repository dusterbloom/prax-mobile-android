#!/bin/bash
set -e

# Basic Android SDK and NDK setup
export ANDROID_HOME="/Users/peppi/Library/Android/sdk"
export ANDROID_NDK_HOME="$ANDROID_HOME/ndk/26.3.11579264"
export ANDROID_NDK_ROOT="$ANDROID_NDK_HOME"  # Some tools look for this instead

# Toolchain setup
export TOOLCHAIN="$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/darwin-x86_64"
export PATH="$TOOLCHAIN/bin:$PATH"

# Cross-compilation settings
export TARGET_CC="$TOOLCHAIN/bin/aarch64-linux-android21-clang"
export TARGET_CXX="$TOOLCHAIN/bin/aarch64-linux-android21-clang++"
export AR="$TOOLCHAIN/bin/llvm-ar"
export RANLIB="$TOOLCHAIN/bin/llvm-ranlib"

# RocksDB specific settings
export ROCKSDB_STATIC=1
export ROCKSDB_USE_RTTI=1
export CC=$TARGET_CC
export CXX=$TARGET_CXX

# Print environment for verification
echo "Android NDK: $ANDROID_NDK_HOME"
echo "Toolchain: $TOOLCHAIN"
echo "Target CC: $TARGET_CC"
