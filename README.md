# Snippet Library (Flutter)

A Flutter client for the Snippet Library REST API, built to learn Flutter and
Dart. The goal is to work with either the Express or the NestJS version of the
API without changing the app.

Status: work in progress. The app shows an empty list page; loading snippets
from the API comes next.

## Requirements

- Flutter 3.47 (stable) with Dart `^3.13.7`
- Chrome, to run the web version

## Commands

```sh
flutter pub get          # install packages
flutter run -d chrome    # run the app in Chrome
flutter analyze          # static analysis
flutter test             # run the tests
dart format .            # format the code
```

## Structure

- `lib/main.dart` starts the app.
- `lib/snippet_library_app.dart` is the root widget (`SnippetLibraryApp`).
- `lib/snippets/snippet_list/` holds the snippet list page.
- `test/` mirrors `lib/`.
