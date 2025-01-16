#!/bin/bash

# NDK path (using the latest version you have installed)
export ANDROID_NDK_HOME=$ANDROID_HOME/ndk/26.3.11579264

# Add NDK tools to PATH
export PATH=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/darwin-x86_64/bin:$PATH

# Set up cross-compilation environment variables
export AR_aarch64_linux_android=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/darwin-x86_64/bin/llvm-ar
export CC_aarch64_linux_android=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/darwin-x86_64/bin/aarch64-linux-android21-clang
export CXX_aarch64_linux_android=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/darwin-x86_64/bin/aarch64-linux-android21-clang++

export AR_armv7_linux_androideabi=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/darwin-x86_64/bin/llvm-ar
export CC_armv7_linux_androideabi=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/darwin-x86_64/bin/armv7a-linux-androideabi21-clang
export CXX_armv7_linux_androideabi=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/darwin-x86_64/bin/armv7a-linux-androideabi21-clang++

export AR_x86_64_linux_android=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/darwin-x86_64/bin/llvm-ar
export CC_x86_64_linux_android=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/darwin-x86_64/bin/x86_64-linux-android21-clang
export CXX_x86_64_linux_android=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/darwin-x86_64/bin/x86_64-linux-android21-clang++

export AR_i686_linux_android=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/darwin-x86_64/bin/llvm-ar
export CC_i686_linux_android=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/darwin-x86_64/bin/i686-linux-android21-clang
export CXX_i686_linux_android=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/darwin-x86_64/bin/i686-linux-android21-clang++

# Verify the environment
echo "Checking NDK setup..."
ls $ANDROID_NDK_HOME/toolchains/llvm/prebuilt/darwin-x86_64/bin/aarch64-linux-android21-clang
