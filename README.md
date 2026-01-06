# Samsung One UI 6 Clock Widget

A beautiful clock application for Android with a native home screen widget, built with Flutter and Material 3. The design replicates Samsung One UI 6 aesthetic with glassmorphism effects and Material You dynamic color integration.

## ✨ Features

### 🎨 Design
- **Samsung One UI 6** style with 28dp rounded corners
- **Glassmorphism** effects with semi-transparent panels
- **Material 3** with Dynamic Color (Material You)
- **Dark Mode** support with automatic theme switching
- **Responsive** layout that adapts to any screen size

### 📱 Native Widget
- **TextClock** for automatic time/date updates (zero battery drain)
- **Home Screen Widget** with 4x3 configurable grid size
- **Theme Awareness** - automatically switches light/dark backgrounds
- **Efficient Updates** - 60-second intervals

### 🎯 Flutter App
- **Expandable SliverAppBar** with gradient background
- **Real-time Clock** updating every second
- **Material You Integration** - colors from device wallpaper
- **Smooth Animations** and transitions
- **Feature Showcase** with organized card layout

## 🚀 Quick Start

### Prerequisites
- Flutter 3.8.1 or higher
- Dart 3.8.1 or higher
- Android SDK 28 (API level 28) or higher

### Installation

1. **Clone/Extract the project**
   ```bash
   cd clock_widget
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

4. **Add widget to home screen**
   - Long-press on home screen
   - Select "Widgets"
   - Search for "Clock Widget"
   - Choose desired size and tap to add

## 📁 Project Structure

```
clock_widget/
├── lib/
│   └── main.dart                           # Flutter app
├── android/
│   └── app/
│       └── src/main/
│           ├── kotlin/.../ClockWidgetProvider.kt
│           ├── res/
│           │   ├── drawable/
│           │   │   └── widget_background.xml    # Light theme
│           │   ├── drawable-night/
│           │   │   └── widget_background.xml    # Dark theme
│           │   ├── layout/
│           │   │   └── widget_layout.xml        # Widget UI
│           │   ├── values/
│           │   │   └── strings.xml
│           │   └── xml/
│           │       └── clock_widget_info.xml    # Widget config
│           └── AndroidManifest.xml              # Widget registration
├── pubspec.yaml                            # Dependencies
├── IMPLEMENTATION_GUIDE.md                 # Detailed guide
└── README.md                               # This file
```

## 🎯 Key Components

### 1. Native Widget (Android)
**ClockWidgetProvider.kt** - Manages widget lifecycle and updates
- Inflates `widget_layout.xml` layout
- No custom logic needed - TextClock handles everything
- Supports light/dark theme automatically

**widget_layout.xml** - Widget UI
- TextClock for hours:minutes (56sp)
- TextClock for date (14sp)
- Responsive padding and centering
- sans-serif-medium font

**widget_background.xml** - Glassmorphism effect
- Light mode: White with 88% opacity (#E0FFFFFF)
- Dark mode: Dark with 88% opacity (#E01A1A1A)
- 28dp border radius (One UI 6 standard)

### 2. Flutter Application (main.dart)
**ClockApp** - Root widget with theme configuration
- DynamicColorBuilder for Material You
- Material 3 design system
- Light/dark theme variants

**ClockHome** - Main screen
- SliverAppBar with flexible space
- Real-time clock display (Stream-based)
- Feature cards and settings UI
- Responsive padding and sizing

## 🎨 Design Specifications

### Colors
| Element | Light Mode | Dark Mode |
|---------|-----------|-----------|
| Background | #E0FFFFFF (White) | #E01A1A1A (Dark) |
| Primary | Dynamic (Wallpaper) | Dynamic (Wallpaper) |
| Text (Primary) | Black | White |
| Text (Secondary) | #666666 | Gray |

### Typography
- **Font Family**: sans-serif-medium
- **Time Display**: 56sp, Bold
- **Date Display**: 14sp, Medium
- **Headings**: 28sp, Semibold
- **Body Text**: 14sp, Medium

### Spacing
- **Widget Padding**: 24dp
- **Corner Radius**: 28dp
- **Card Elevation**: 20dp shadow
- **Section Spacing**: 24dp
- **Item Padding**: 16dp

## 🔧 Configuration

### Widget Update Frequency
Edit `android/app/src/main/res/xml/clock_widget_info.xml`:
```xml
<appwidget-provider
    ...
    android:updatePeriodMillis="60000"
    ...
/>
```

### Widget Size
Default: 4x3 cells (approximately 200x200dp min)
```xml
android:targetCellWidth="4"
android:targetCellHeight="3"
```

### Colors
**Light Mode**: `android/app/src/main/res/drawable/widget_background.xml`
```xml
<solid android:color="#E0FFFFFF" />
```

**Dark Mode**: `android/app/src/main/res/drawable-night/widget_background.xml`
```xml
<solid android:color="#E01A1A1A" />
```

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  dynamic_color: ^1.6.8    # Material You color extraction
  home_widget: ^0.4.3      # Widget communication (optional)

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
```

## 🎯 Material You Integration

The app automatically:
1. Extracts the primary color from your device wallpaper
2. Generates a complete Material 3 color scheme
3. Applies colors to:
   - Primary accent (time display)
   - Card backgrounds
   - Icon backgrounds
4. Respects system light/dark mode

**No manual configuration needed!**

## 🌓 Dark Mode Support

The app automatically:
- Detects system theme preference
- Uses `drawable/` files for light mode
- Uses `drawable-night/` files for dark mode
- Applies Material 3 theme accordingly
- Maintains color contrast requirements

## ⚙️ Advanced Customization

### Change Theme Colors
In `lib/main.dart`:
```dart
lightColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.blue,  // Change this
  brightness: Brightness.light,
);
```

### Modify Widget Layout
Edit `android/app/src/main/res/layout/widget_layout.xml`:
- Adjust text sizes
- Change padding/margins
- Add additional elements
- Modify font families

### Update Time Format
In `widget_layout.xml`:
```xml
<TextClock
    android:format12Hour="h:mm"
    android:format24Hour="HH:mm"
/>
```

## 🚀 Building for Release

```bash
# Build APK
flutter build apk --release

# Build App Bundle (for Play Store)
flutter build appbundle --release

# Install on device
flutter install
```

## 📝 Notes

- The widget uses `TextClock` which automatically updates without consuming battery
- Material You colors are extracted dynamically - no hardcoding needed
- The app supports both 12-hour and 24-hour time formats (system preference)
- All animations are optimized for smooth 60fps performance
- The design follows Material 3 and Samsung One UI 6 guidelines

## 🔗 Resources

- [Flutter Documentation](https://flutter.dev)
- [Android Widgets](https://developer.android.com/guide/topics/appwidgets)
- [Material 3 Design](https://m3.material.io)
- [Samsung One UI Design](https://www.samsung.com/global/business/mobile/android/one-ui/)
- [Dynamic Color Package](https://pub.dev/packages/dynamic_color)

## 📄 License

This project is provided as-is. Modify and distribute freely.

---

**Created**: January 6, 2026
**Flutter Version**: 3.8.1+
**Minimum SDK**: API 28
**Status**: Production Ready ✅
