#!/bin/bash
set -e

source ./setup-android-env.sh

echo "Building for Android target..."
RUSTFLAGS="-C target-feature=+crt-static" cargo build --target aarch64-linux-android --release

echo "Generating Kotlin bindings..."
mkdir -p android/src/main/kotlin

cargo run --bin uniffi-bindgen generate \
    --library target/aarch64-linux-android/release/libmobile.so \
    --language kotlin \
    --out-dir android/src/main/kotlin

echo "Copying bindings to module..."
mkdir -p ../react-native-expo/modules/penumbra-sdk-module/android/src/main/kotlin
cp -r android/src/main/kotlin/* ../react-native-expo/modules/penumbra-sdk-module/android/src/main/kotlin/

echo "Done!"
