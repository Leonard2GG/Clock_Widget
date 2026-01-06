#!/bin/bash

# Installation and Build Script for Clock Widget
# This script automates the setup process

echo "🚀 Clock Widget - Samsung One UI 6 Setup"
echo "========================================="
echo ""

# Step 1: Get Flutter dependencies
echo "📦 Installing Flutter dependencies..."
flutter pub get
if [ $? -eq 0 ]; then
    echo "✅ Dependencies installed successfully"
else
    echo "❌ Failed to install dependencies"
    exit 1
fi

echo ""

# Step 2: Clean build artifacts
echo "🧹 Cleaning build artifacts..."
flutter clean
flutter pub get

echo ""

# Step 3: Build for Android
echo "🔨 Building Android app..."
flutter build apk --release

if [ $? -eq 0 ]; then
    echo "✅ Android build completed successfully"
else
    echo "❌ Android build failed"
    exit 1
fi

echo ""

# Step 4: Summary
echo "========================================="
echo "✨ Setup completed successfully!"
echo ""
echo "Next steps:"
echo "1. Connect your Android device"
echo "2. Run: flutter install"
echo "3. Or: flutter run"
echo "4. Long-press home screen → Widgets → Clock Widget"
echo ""
echo "========================================="
