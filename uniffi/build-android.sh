#!/bin/bash
set -e

# Source the environment setup
source ./setup-android-env.sh

# Clean any previous builds
cargo clean

# Build for ARM64
echo "Building for aarch64-linux-android..."
cargo build --target aarch64-linux-android --release

# Create output directories
mkdir -p ../react-native-expo/modules/penumbra-sdk-module/android/src/main/jniLibs/arm64-v8a

# Copy the library
cp target/aarch64-linux-android/release/libmobile.so ../react-native-expo/modules/penumbra-sdk-module/android/src/main/jniLibs/arm64-v8a/

echo "Android build completed!"


echo "Verifying build artifacts..."

LIBRARY_PATH="../react-native-expo/modules/penumbra-sdk-module/android/src/main/jniLibs/arm64-v8a/libmobile.so"

# Check if library exists
if [ ! -f "$LIBRARY_PATH" ]; then
    echo "Error: Library not found at $LIBRARY_PATH"
    exit 1
fi

# Check file permissions
if [ ! -r "$LIBRARY_PATH" ]; then
    echo "Error: Library is not readable"
    chmod 644 "$LIBRARY_PATH"
fi

# Verify it's a valid library (basic check)
if ! file "$LIBRARY_PATH" | grep -q "shared object"; then
    echo "Error: Not a valid shared object file"
    exit 1
fi

echo "Build verification completed successfully!"



# Generate Kotlin bindings from the compiled library
echo "Generating Kotlin bindings..."
cargo run --features=uniffi/cli --bin uniffi-bindgen generate \
    --library target/aarch64-linux-android/release/libmobile.so \
    --language kotlin \
    --out-dir ../react-native-expo/modules/penumbra-sdk-module/android/src/main/kotlin/

echo "Android bindings generated and copied !"