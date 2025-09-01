# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter application for a Bible reader app ("biblia_meno") that displays Bible verses in Spanish. The app uses Riverpod for state management, Hive for local storage, and includes features like verse search, notifications, and reading modes.

## Development Commands

### Build and Run
```bash
# Run the app in debug mode
flutter run

# Build APK for Android
flutter build apk

# Build for Windows
flutter build windows
```

### Code Generation
```bash
# Generate model classes (for .g.dart files)
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode for automatic generation
flutter pub run build_runner watch --delete-conflicting-outputs
```

### Code Quality
```bash
# Run static analysis
flutter analyze

# Run tests
flutter test

# Format code
dart format lib/
```

## Architecture

### State Management
- Uses **Riverpod** for state management with providers in `lib/providers/`
- Main provider: `bibliaProvider` manages Bible data loading
- `appStateProvider` handles app initialization state

### Data Layer
- Repository pattern implemented in `lib/data/`
- `RepositoryVersos` interface with `RepositoryVersosImpl` implementation
- Bible data loaded from JSON assets (`assets/biblia.json`)

### Models
- Located in `lib/models/`
- Uses `json_serializable` for JSON parsing
- Generated files (*.g.dart) are created via build_runner
- Key models: `Biblia`, `Libro`, `Chapter`, `Verse`, `NotificationModel`

### UI Structure
- **Screens**: Main screens in `lib/screens/` and `lib/pages/`
  - `Home`: Main navigation screen
  - `BookPage`: Shows books of the Bible
  - `ChapterScreen`: Displays chapters and verses
- **Widgets**: Reusable components in `lib/widgets/`
  - Custom drawer, verse cards, search delegates

### Key Features
- **Local Notifications**: Implemented in `lib/utils/local_notifications.dart`
- **Hive Database**: For storing notification preferences
- **Search**: Verse search functionality with custom delegate
- **Reading Mode**: Special reading view for verses

## Dependencies

Main packages:
- `flutter_riverpod`: State management
- `hive` & `hive_flutter`: Local storage
- `flutter_local_notifications`: Push notifications
- `json_annotation` & `json_serializable`: JSON parsing
- `logger`: Logging utility

## Important Notes

- The app uses two JSON data files in `assets/`: `biblia.json` and `rvg.json`
- Hive adapters need to be registered in `main()` before use
- The app supports Spanish language primarily
- Windows platform files are present but uncommitted