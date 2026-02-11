#!/bin/bash

echo "🚀 Starting Project Setup..."

# 1. Clean Project
echo "🧹 Cleaning project..."
flutter clean

# 2. Get Dependencies
echo "📦 Fetching dependencies..."
flutter pub get

# 3. Generate Code (Riverpod, Retrofit, Assets, JSON)
echo "🏗️  Running Build Runner (this might take a while)..."
dart run build_runner build --delete-conflicting-outputs

# 4. Generate Splash Screen
echo "💦 Generating Splash Screen..."
dart run flutter_native_splash:create

echo "✅ Setup Complete! You can now run the app:"
echo "flutter run"
