# Snippet Library - Flutter

A Flutter client for the Snippet Library API, built to learn Flutter and Dart. It is designed to work with either the Express or the NestJS version of the API, with no code change. It runs in Chrome today, and Android is planned.

Status: work in progress. The app shows an empty snippet list page. Loading snippets from the API is the next step, see the Roadmap.

## Features

- A Material 3 app shell (`MaterialApp`) with a title bar and a snippet list page.
- A widget test that starts the app and checks the page text.

Everything else is on the Roadmap below. This list grows as features land.

## Tech stack

- Flutter 3.47 (stable) and Dart `^3.13.7`
- Material 3 widgets
- `flutter_lints` for static analysis, `dart format` for formatting

## Requirements

- The Flutter SDK, with `flutter` on your PATH. Run `flutter doctor` to check the setup.
- Chrome, to run the web version.

## Quick start

1. Install the packages:

   ```sh
   flutter pub get
   ```

2. Run the app in Chrome:

   ```sh
   flutter run -d chrome
   ```

   In VS Code, you can also click **Debug** above `void main()` in `lib/main.dart`. A run started from the terminal reloads only when you press `r` in that terminal. A run started from VS Code reloads on save.

3. The app opens in a Chrome window with the title "Snippet Library" and the text "No snippets yet".

The app does not call the API yet, so no API needs to be running.

## Commands

| Command | What it does |
| --- | --- |
| `flutter pub get` | Install the packages from `pubspec.yaml` |
| `flutter run -d chrome` | Run the app in Chrome (debug mode) |
| `flutter analyze` | Run static analysis with `flutter_lints` |
| `flutter test` | Run the tests in `test/` |
| `dart format .` | Format the Dart code |

## How it is organized

```text
lib/
  main.dart                      Starts the app: runApp(SnippetLibraryApp)
  snippet_library_app.dart       Root widget: MaterialApp, title, first screen
  snippets/
    snippet_list/                SnippetListPage (placeholder for now)
test/
  snippet_library_app_test.dart  Starts the app, checks the page text
android/                         Generated Android project (not used yet)
web/                             Generated web host page (index.html, icons)
```

The layout follows the Vue app where Dart allows: `lib/snippets/` will get `models/` (data classes) and `services/` (the API client) next to `snippet_list/`. Each class has its own file, named after it in snake_case. A widget and its private `State` class are the one exception, because Dart privacy works per file.

## How it works

`main()` calls `runApp` with `SnippetLibraryApp`. That widget returns a `MaterialApp` whose first screen (`home`) is `SnippetListPage`, a `Scaffold` with an app bar and a centered message.

Flutter draws its own UI on a canvas instead of using HTML elements, so the page in Chrome has no DOM elements to inspect.

## Notes

- The red DEBUG ribbon is hidden with `debugShowCheckedModeBanner: false`. Debug mode itself is still slower than a release build.
- The Express API allows requests only from `http://localhost:5173`, and the NestJS API only from `http://localhost:4200`. When the app starts calling the API, it will be run in Chrome with `--web-port` set to match the API in use.

## Roadmap

- Snippet models and the REST data source, shared by both APIs.
- The snippet list loaded from the API, with loading, error and empty states.
- GraphQL as a second transport, switched with one setting, as in the Vue and Angular apps.
- Search and pagination.
- Create, edit and delete.
- Running on an Android emulator.
