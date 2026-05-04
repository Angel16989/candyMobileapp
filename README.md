# CandyLand Flutter App

This repository is now being migrated from a React/Vite storefront into a Flutter app in iterative releases.

## Current Status

The first Flutter iteration is in place and mirrors the original storefront flow:

- home screen with a hero banner and featured candies
- shop screen focused on the `Lollies` category
- candy details screen with quantity selection
- bag screen with cart updates and total calculation

The original React source is still present under `src/` as a migration reference while we move feature-by-feature into Flutter.

## Flutter Project Structure

- `lib/main.dart`: Flutter entrypoint
- `lib/app.dart`: app shell, navigation, and cart state
- `lib/data/`: sample candy catalog
- `lib/models/`: Dart data models
- `lib/screens/`: home, shop, details, bag, and account screens
- `lib/widgets/`: reusable UI pieces
- `lib/theme/`: CandyLand theme and color palette

## Run Locally

Prerequisite: Flutter SDK installed and available on your `PATH`

1. Install packages:
   `flutter pub get`
2. Run the app:
   `flutter run`

For Chrome:

`flutter run -d chrome`

## Run With Docker

This is the easiest way to verify the Flutter web app on a Windows laptop with Docker Desktop.

Run these commands from the repository root:

`/path/to/candyMobileapp`

1. Run the Flutter test suite in a container:
   `docker build --target verify -t candy-mobile-app:verify .`
2. Build the web image:
   `docker build --target web -t candy-mobile-app:web .`
3. Serve the web app:
   `docker run --rm -p 8080:80 candy-mobile-app:web`
4. Open:
   `http://localhost:8080`

If your Docker install includes Compose, you can also use:

- `docker compose run verify`
- `docker compose up --build web`

### What The Docker Setup Does

- installs Flutter `3.41.9` from the official Linux stable SDK archive
- resolves Dart and Flutter packages
- runs `flutter test` in the `verify` target
- builds `flutter build web --release`
- serves the generated site through Nginx on port `8080`

## iOS Testing

iOS testing cannot be run from this Linux machine or from Docker on a Windows laptop.

Why:

- iOS builds and simulators require Xcode
- Xcode only runs on macOS
- Docker does not bypass that requirement

What we can do from here:

- run Flutter unit and widget tests
- build and verify the web app
- prepare the project for Android, web, and Linux
- later set up macOS CI or a Mac-based build machine for iOS

## Notes

- Flutter is now installed in the current environment and the app has been verified with `flutter test` and `flutter build web`.
- Docker files are included for Windows-friendly web verification without requiring a local Flutter SDK install on the laptop.
- The legacy Node/Vite files can be removed in a later cleanup iteration once the Flutter app is verified and we are comfortable dropping the old implementation.
