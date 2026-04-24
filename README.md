# Psychol - Privacy-First Mental Wellness App

A beautiful, minimal Flutter application for tracking mood and mental wellness with **privacy-first design, smooth animations, and a clinical aesthetic**.

## ✨ Key Features

- **🧠 Mood Logging**: Simple emoji-based mood tracking with optional journal notes
- **📊 Dashboard**: Weekly mood trends, insights, and wellness tips
- **🎨 Theme System**: Light, Dark, and Medical-themed interfaces
- **⚙️ Settings**: Customizable notifications, theme switching, privacy controls
- **🔐 Privacy**: All data stored locally, never shared or uploaded
- **✨ Smooth Animations**: Subtle transitions and micro-interactions throughout

## 🚀 Quick Start

### Prerequisites
```bash
Flutter >= 3.13.0
Dart >= 3.1.0
```

### Installation & Run

```bash
# Install dependencies
flutter pub get

# Run the app
flutter run
```

### Available Themes
- **Light**: Fresh, airy design (default)
- **Dark**: Easy on the eyes for low-light
- **Medical**: Clinical, professional healthcare aesthetic

## 📱 Screens

| Dashboard | Mood Log | Settings |
|-----------|----------|----------|
| Weekly trends | Emoji selector | Theme switcher |
| Quick insights | Journal entry | Notifications |
| Wellness tips | Privacy notice | Privacy info |

## 🏗️ Architecture

- **State Management**: Riverpod
- **Theme System**: Material 3 with 3 complete palettes
- **Navigation**: Bottom tab bar with smooth transitions
- **Animations**: Custom page transitions, staggered lists, micro-interactions
- **Database**: SQLite (prepared, ready for mood history)
- **Notifications**: Local notifications for check-ins & reminders

### Folder Structure
```
lib/
├── app/              # Navigation, theme state, preferences
├── core/             # Theme, widgets, services
├── features/         # Dashboard, Mood Log, Settings
└── main.dart
```

## 🎨 Design Highlights

- **Minimal UI**: Only essential elements, zero clutter
- **Clinical Aesthetic**: Professional colors, clean typography
- **Smooth Interactions**: Scale, fade, slide animations on all interactions
- **Accessibility**: High contrast, readable fonts, proper spacing
- **Dark Mode**: Full support with 3 distinct palettes

## 📚 Documentation

For detailed documentation including:
- Complete color palettes
- Typography system
- Component usage
- Animation examples
- Database schema (prepared)
- Development guide

See [PROJECT_DOCUMENTATION.md](PROJECT_DOCUMENTATION.md)

## 🔧 Tech Stack

- **Framework**: Flutter 3.13+
- **State Management**: Riverpod 3.3+
- **Database**: SQLite 2.4+ (prepared)
- **Notifications**: flutter_local_notifications 21.0+
- **Design System**: Material Design 3

## 📦 Dependencies

```yaml
flutter_riverpod: ^3.3.1      # State management
sqflite: ^2.4.2               # Local database
flutter_local_notifications: ^21.0.0  # Notifications
timezone: ^0.11.0             # Timezone support
```

## 🔐 Privacy

✓ **100% Local Storage** - No cloud sync  
✓ **No Tracking** - No analytics or telemetry  
✓ **Encrypted** - SQLite ready for encryption  
✓ **Open Source** - Transparent, auditable code  

## 🎯 Core Widgets

### SmoothCard
Elegant card with subtle border and shadow
```dart
SmoothCard(child: Text('Content'))
```

### SmoothButton
Interactive button with scale animation
```dart
SmoothButton(label: 'Save', onPressed: () {})
```

### SmoothTextField
Input with focus animation
```dart
SmoothTextField(label: 'Mood', hint: 'How are you?')
```

### Animations
```dart
SmoothPageTransition(page: MyScreen())
StaggeredAnimationBuilder(children: [...])
```

## 📋 Current Implementation

✅ **Completed**:
- 3 theme system (light/dark/medical)
- Dashboard with trends & insights
- Mood logging with 5-emoji selector
- Settings with theme & notification controls
- Bottom navigation
- Smooth animations & transitions
- Riverpod state management
- Local notification service (structure)

🚧 **Prepared For**:
- SQLite database integration
- Full notification scheduling
- Mood history & analytics
- Data export

## 🚀 Next Steps

1. Integrate SQLite for persistent mood storage
2. Implement mood analytics & pattern detection
3. Add scheduled notifications
4. Create mood history/calendar view
5. Add data backup & export features

## 💡 Usage Example

```dart
// Access theme provider
final themeMode = ref.watch(themeModeProvider);

// Change theme
ref.read(themeModeProvider.notifier)
    .setThemeMode(AppThemeMode.dark);

// Access user preferences
final prefs = ref.watch(userPreferencesProvider);

// Update notification settings
ref.read(userPreferencesProvider.notifier)
    .updateMoodCheckInInterval(6);
```

## 🎓 Learning Resources

This project demonstrates:
- ✅ Clean Flutter architecture
- ✅ Riverpod state management
- ✅ Material 3 theme system
- ✅ Custom animations & transitions
- ✅ Medical/clinical UI design
- ✅ Local notifications
- ✅ SQLite database preparation

Great as a reference or template for your own projects.

## 📄 License

Open source - feel free to use, modify, and share.

---

**Made with care for mental wellness.** 🧠✨

For questions or contributions, feel free to open an issue or PR.
