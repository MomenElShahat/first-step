#!/bin/bash
set -e

echo "🧹 Cleaning Flutter build..."
flutter clean

echo "🧹 Flutter pub get..."
flutter pub get

echo "🧹 Removing old Pods & locks..."
cd ios
rm -rf Pods Podfile.lock

echo "🧹 Cleaning CocoaPods cache..."
pod cache clean --all
rm -rf ~/Library/Caches/CocoaPods

echo "🧹 Cleaning Xcode DerivedData..."
rm -rf ~/Library/Developer/Xcode/DerivedData

echo "⚙️ Increasing Git buffer size..."
git config --global http.postBuffer 524288000
git config --global http.version HTTP/1.1

echo "📦 Installing Pods..."
pod install --repo-update

cd ..

echo "✅ Done! Try: flutter run"
