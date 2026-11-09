# Snippet Library - Flutter

A Flutter client for the Snippet Library API, built to learn Flutter and Dart. It is designed to work with either the Express or the NestJS version of the API, with no code change. It runs in Chrome today, and Android is planned.

Status: work in progress. The app shows an empty snippet list page. The data layer (models and the REST data source) is in place and tested against the Express API. Showing the list on screen is the next step, see the Roadmap.

## Features

- A Material 3 app shell (`MaterialApp`) with a title bar and a snippet list page.
- Snippet models (`Snippet`, `PaginationMetadata`, `FindSnippetsResult`) built from the API's JSON.
- A `SnippetDataSource` contract and its REST implementation, `SnippetRestApi`: it lists snippets with optional search, page and limit, and turns API errors into an `ApiException` that carries the server's own message. The screen does not use it yet.
- Unit tests for the models, and a widget test that starts the app and checks the page text.

Everything else is on the Roadmap below. This list grows as features land.

## Tech stack

- Flutter 3.47 (stable) and Dart `^3.13.7`
- Material 3 widgets
- The `http` package for REST calls
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

The app screens do not call the API yet, so no API needs to be running to start the app.

## Commands

| Command | What it does |
| --- | --- |
| `flutter pub get` | Install the packages from `pubspec.yaml` |
| `flutter run -d chrome` | Run the app in Chrome (debug mode) |
| `flutter analyze` | Run static analysis with `flutter_lints` |
| `flutter test` | Run the tests in `test/` |
| `dart format .` | Format the Dart code |

## Configuration

The API address is `apiBaseUrl` in `lib/api_config.dart`. It defaults to `http://localhost:3000`, and you can change it when you start the app, with no code change:

```sh
flutter run -d chrome --dart-define=API_BASE_URL=http://10.0.2.2:3000
```

`10.0.2.2` is how the Android emulator reaches your computer. Values passed with `--dart-define` are compiled into the app, so do not put secrets in them.

## How it is organized

```text
lib/
  main.dart                      Starts the app: runApp(SnippetLibraryApp)
  snippet_library_app.dart       Root widget: MaterialApp, title, first screen
  api_config.dart                apiBaseUrl (API_BASE_URL setting)
  snippets/
    models/                      Snippet, PaginationMetadata, FindSnippetsResult
    services/                    SnippetDataSource (contract), SnippetRestApi, ApiException
    snippet_list/                SnippetListPage (placeholder for now)
test/
  snippet_library_app_test.dart  Starts the app, checks the page text
  snippets/models/               Unit tests for the models
android/                         Generated Android project (not used yet)
web/                             Generated web host page (index.html, icons)
```

The layout follows the Vue app where Dart allows. Each class has its own file, named after it in snake_case. A widget and its private `State` class are the one exception, because Dart privacy works per file.

## How it works

`main()` calls `runApp` with `SnippetLibraryApp`. That widget returns a `MaterialApp` whose first screen (`home`) is `SnippetListPage`, a `Scaffold` with an app bar and a centered message.

Flutter draws its own UI on a canvas instead of using HTML elements, so the page in Chrome has no DOM elements to inspect.

### Loading snippets

Screens will talk to `SnippetDataSource`, not to a specific transport. `SnippetRestApi.getAll` builds `GET /snippets` with the optional `search`, `page` and `limit` parameters, checks the status, decodes the JSON and returns a `FindSnippetsResult`. If the API answers with an error, it throws an `ApiException` whose message is the server's `message`. Express sends that as text. NestJS may send a list, which is joined with `; `. If the body has no usable message, the text is "Failed to load snippets (status)".

## Notes

- The red DEBUG ribbon is hidden with `debugShowCheckedModeBanner: false`. Debug mode itself is still slower than a release build.
- The Express API allows requests only from `http://localhost:5173`, and the NestJS API only from `http://localhost:4200`. When the app starts calling the API, it will be run in Chrome with `--web-port` set to match the API in use.
- An empty search result reports page 1 of 0 pages.

## Roadmap

- The snippet list loaded from the API, with loading, error and empty states.
- GraphQL as a second transport, switched with one setting, as in the Vue and Angular apps.
- Search and pagination.
- Create, edit and delete.
- Running on an Android emulator.
