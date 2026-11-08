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

Prerequisites: Flutter stable and the FlutterFire CLI.

```sh
flutter pub get
flutterfire configure
flutter run
```

After `flutterfire configure`, replace the placeholder values in:

- `lib/firebase_options.dart`
- `android/app/google-services.json`

Keep real Firebase secrets out of public source control when appropriate.

## Layers and data flow

Each feature is split into three layers; dependencies only point inward.

```text
presentation (pages, widgets, view models)   Riverpod notifiers, no Firebase imports
      |
domain (entities, repository contracts, use cases)   pure Dart
      |
data (data sources, models, repository impls)   Firebase / network, mapped to domain
```

- Errors cross layer boundaries as `Failure` values wrapped in `Result` (`lib/core/result`, `lib/core/errors`) instead of thrown exceptions.
- Firebase instances (Auth, Firestore, Storage, Messaging, Analytics) are exposed as Riverpod providers in `lib/core/firebase`, so tests can override them.
- Routing lives in `lib/app/navigation`; role-specific shells (patient, doctor, admin) are keyed on `UserRole`.
- Theme tokens (colors, spacing, text styles) are centralised under `lib/app/theme` and `lib/core/theme`; responsive helpers are in `lib/core/responsive`.

## Quality checks

```sh
flutter analyze
flutter test
```

Both run in CI (`.github/workflows/ci.yml`) on pushes to `main` and on pull requests.

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
