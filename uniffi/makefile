.PHONY: all build-ios build-android copy clean validate-env test-build

# Default target
all: validate-env build-ios build-android copy

# Environment validation
validate-env:
	@echo "Validating build environment..."
	@command -v rustc >/dev/null 2>&1 || { echo "Error: Rust not installed"; exit 1; }
	@command -v cargo >/dev/null 2>&1 || { echo "Error: Cargo not installed"; exit 1; }
	@command -v xcodebuild >/dev/null 2>&1 || { echo "Error: Xcode not installed"; exit 1; }
	@test -d "$$ANDROID_HOME" || { echo "Error: ANDROID_HOME not set"; exit 1; }
	@test -d "$$ANDROID_HOME/ndk/26.3.11579264" || { echo "Error: Required NDK not found"; exit 1; }
	@cargo install uniffi-bindgen

# iOS Build
build-ios:
	@echo "Building for iOS..."
	cargo build
	cargo run --bin uniffi-bindgen generate --library ./target/debug/libmobile.dylib --language swift --out-dir ./bindings
	@echo "Building for iOS targets..."
	for target in aarch64-apple-darwin aarch64-apple-ios aarch64-apple-ios-sim; do \
		rustup target add $$target; \
		cargo build --release --target=$$target; \
	done
	@echo "Setting up XCFramework..."
	mv ./bindings/mobileFFI.modulemap ./bindings/module.modulemap
	rm -rf "ios/Mobile.xcframework"
	xcodebuild -create-xcframework \
		-library ./target/aarch64-apple-ios-sim/release/libmobile.a -headers ./bindings \
		-library ./target/aarch64-apple-ios/release/libmobile.a -headers ./bindings \
		-output "ios/Mobile.xcframework"

# Android Build
build-android:
	@echo "Building for Android..."
	for target in aarch64-linux-android armv7-linux-androideabi x86_64-linux-android i686-linux-android; do \
		rustup target add $$target; \
		cargo build --release --target=$$target; \
	done
	cargo run --bin uniffi-bindgen generate --library ./target/debug/libmobile.dylib --language kotlin --out-dir ./android/src/main/kotlin

# Copy artifacts
copy:
	@echo "Creating directories if they don't exist..."
	mkdir -p ../react-native-expo/modules/penumbra-sdk-module/ios
	mkdir -p ../react-native-expo/modules/penumbra-sdk-module/android/src/main/jniLibs/arm64-v8a
	mkdir -p ../react-native-expo/modules/penumbra-sdk-module/android/src/main/jniLibs/armeabi-v7a
	mkdir -p ../react-native-expo/modules/penumbra-sdk-module/android/src/main/jniLibs/x86_64
	mkdir -p ../react-native-expo/modules/penumbra-sdk-module/android/src/main/jniLibs/x86
	
	@echo "Copying iOS framework..."
	rm -rf ../react-native-expo/modules/penumbra-sdk-module/ios/Mobile.xcframework
	cp -r ./ios/Mobile.xcframework ../react-native-expo/modules/penumbra-sdk-module/ios
	
	@echo "Copying Android libraries..."
	cp ./target/aarch64-linux-android/release/libmobile.so ../react-native-expo/modules/penumbra-sdk-module/android/src/main/jniLibs/arm64-v8a/
	cp ./target/armv7-linux-androideabi/release/libmobile.so ../react-native-expo/modules/penumbra-sdk-module/android/src/main/jniLibs/armeabi-v7a/
	cp ./target/x86_64-linux-android/release/libmobile.so ../react-native-expo/modules/penumbra-sdk-module/android/src/main/jniLibs/x86_64/
	cp ./target/i686-linux-android/release/libmobile.so ../react-native-expo/modules/penumbra-sdk-module/android/src/main/jniLibs/x86/

# Test build
test-build:
	@echo "Testing iOS build..."
	eas build --profile development --platform ios
	@echo "Testing Android build..."
	eas build --profile development --platform android

# Clean
clean:
	@echo "Cleaning build artifacts..."
	rm -rf ./target
	rm -rf ./bindings
	rm -rf ./ios/Mobile.xcframework
	rm -rf ./android/src/main/jniLibs
	rm -rf ../react-native-expo/modules/penumbra-sdk-module/ios/Mobile.xcframework
	rm -rf ../react-native-expo/modules/penumbra-sdk-module/android/src/main/jniLibs