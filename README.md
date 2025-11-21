# Riyada Frontend — Flutter App
Riyada is a sports–court booking application built with Flutter.
Users can search courts, apply filters, view details, check amenities, explore the court location on a map, and make bookings.

This README provides a short setup wiki for running and contributing to the project.

# Getting Started
### 1. Prerequisites
Before running the project, make sure you have:
* Flutter SDK 3.x or later
(Install: https://docs.flutter.dev/get-started/install)
* Dart SDK (included with Flutter)
* Android Studio or VS Code
* A physical device or emulator (Android API)

Check Flutter installation:
```shell
flutter doctor
```

### 2. Clone the Repository
```shell
git clone https://github.com/M-Zeineddine/riyada_frontend.git
cd riyada_frontend
```
### 3. Install Dependencies
```shell
flutter pub get
```

### 4. Project Structure
```
lib/
 ├─ app/
 │   ├─ features/
 │   │   ├─ booking/
 │   │   │   ├─ data/
 │   │   │   ├─ application/
 │   │   │   ├─ presentation/
 │   │   ├─ court/
 │   │   ├─ home/
 │   │   ├─ profile/
 │   │   └─ welcome/
 │   ├─ shared/
 │   ├─ app_shell_scaffold.dart
 │   └─ router.dart
 ├─ main.dart
```

### 5. Run the App
```
flutter run
```
Run on a specific device:
```
flutter devices
flutter run -d <device-id>

e.g
flutter run -d windows
```

### 6. Features Included
* Court search & filter system
* Detailed court page with carousel + amenities
* Integrated map with location pin
* Booking with time slots & durations
* Booking history (upcoming & past)
* Riverpod reactive state
* Smooth bottom navigation (GoRouter Shell)
* Reusable widgets (ImageCarousel, CourtCard, SearchBar, etc.)