# CareLoop

CareLoop is a Flutter/Firebase Android app architecture for a follow-up care system serving patients, doctors, and admins.

This repository currently contains project architecture only. Product features are intentionally not implemented yet.

## Architecture

- Flutter Android app
- Firebase-ready bootstrap
- Riverpod dependency injection and state management
- Clean Architecture by feature
- MVVM presentation layer
- GoRouter navigation
- Responsive layout helpers
- Centralized theme system

## First Local Setup

Flutter is not available in the current shell, so packages were not fetched here. Once Flutter is installed:

```sh
flutter pub get
flutterfire configure
flutter run
```

After `flutterfire configure`, replace the placeholder values in:

- `lib/firebase_options.dart`
- `android/app/google-services.json`

Keep real Firebase secrets out of public source control when appropriate.

## Folder Shape

```text
lib/
  app/                 App bootstrap, routing, theme
  core/                Cross-cutting contracts and infrastructure
  shared/              Reusable shared UI, data, and domain primitives
  features/
    patient/           Patient feature slice
    doctor/            Doctor feature slice
    admin/             Admin feature slice
```
