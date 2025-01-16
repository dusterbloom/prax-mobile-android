#!/bin/bash
set -e

# Source the environment setup
source ./setup-android-env.sh

# Create directories for bindings
mkdir -p android/src/main/kotlin

# Generate Kotlin bindings
echo "Generating Kotlin bindings..."
cargo run --bin uniffi-bindgen generate \
    --library target/aarch64-linux-android/release/libmobile.so \
    --language kotlin \
    --out-dir android/src/main/kotlin

# Copy bindings to the expo module
mkdir -p ../react-native-expo/modules/penumbra-sdk-module/android/src/main/kotlin
cp -r android/src/main/kotlin/* ../react-native-expo/modules/penumbra-sdk-module/android/src/main/kotlin/

echo "Kotlin bindings generation completed!"
