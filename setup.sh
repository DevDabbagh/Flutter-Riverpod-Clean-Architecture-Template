#!/bin/bash

# Flutter Project Setup Script
# Run this script to generate platform folders (iOS, Android) and build runner files.

echo "🚀 Setting up Flutter Riverpod Clean Architecture Project..."

# 1. Generate Platform Folders (iOS, Android, Web, etc.)
echo "📱 Generating iOS and Android folders..."
flutter create . --org com.antigravity.riverpod

# 2. Get Dependencies
echo "📦 Installing dependencies..."
flutter pub get

# 3. Generate Code (Riverpod, JSON, Retrofit)
echo "🏗️  Running Build Runner..."
dart run build_runner build --delete-conflicting-outputs

echo "✅ Setup Complete! You can now run the app with:"
echo "   flutter run"
