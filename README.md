# Snippet Library - Flutter

A Flutter client for the Snippet Library API, built to learn Flutter and Dart. It is designed to work with either the Express or the NestJS version of the API, with no code change. It runs in Chrome today, and Android is planned.

Status: work in progress. The app shows the snippet list loaded from the REST API, with loading, error and empty states. It was checked in Chrome against both the Express and the NestJS API. See the Roadmap for what is next.

## Features

- A Material 3 app shell (`MaterialApp`) with a title bar and a snippet list page.
- A snippet list: one card per snippet with its title, language, a three-line code preview and its tags. While the request runs the page shows a spinner, and it shows a message for an API error, an unreachable API and an empty result.
- Snippet models (`Snippet`, `PaginationMetadata`, `FindSnippetsResult`) built from the API's JSON.
- A `SnippetDataSource` contract and its REST implementation, `SnippetRestApi`: it lists snippets with optional search, page and limit, and turns API errors into an `ApiException` that carries the server's own message. The page receives the data source through its constructor and does not know which implementation it is.
- Unit tests for the models, and widget tests for the page states, the card and the app, using a fake data source instead of the network.

Everything else is on the Roadmap below. This list grows as features land.

## Tech stack

- Flutter 3.47 (stable) and Dart `^3.13.7`
- Material 3 widgets
- The `http` package for REST calls
- `flutter_lints` for static analysis, `dart format` for formatting

## Requirements

- The Flutter SDK, with `flutter` on your PATH. Run `flutter doctor` to check the setup.
- Chrome, to run the web version.
- The Snippet Library API, Express or NestJS, running on port 3000. Only one of them runs at a time.

## Quick start

1. Install the packages:

   ```sh
   flutter pub get
   ```

2. Start the API and run the app in Chrome. The API only accepts requests from one browser address, so the web port must match the API in use:

   ```sh
   flutter run -d chrome --web-port 5173   # Express API
   flutter run -d chrome --web-port 4200   # NestJS API
   ```

   A run started from the terminal reloads only when you press `r` in that terminal (`R` restarts the app and loads the snippets again). In VS Code, you can also click **Debug** above `void main()` in `lib/main.dart`, but that run starts on a web port chosen by Flutter, not 5173 or 4200, so the API will refuse its requests.

3. The app opens in a Chrome window with the title "Snippet Library" and the list of snippets. If the API is not running, the page shows "Could not reach the API".

## Commands

| Command | What it does |
| --- | --- |
| `flutter pub get` | Install the packages from `pubspec.yaml` |
| `flutter run -d chrome --web-port 5173` | Run the app in Chrome against the Express API |
| `flutter run -d chrome --web-port 4200` | Run the app in Chrome against the NestJS API |
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
  main.dart                      Picks the data source and starts the app
  snippet_library_app.dart       Root widget: MaterialApp, title, first screen
  api_config.dart                apiBaseUrl (API_BASE_URL setting)
  snippets/
    models/                      Snippet, PaginationMetadata, FindSnippetsResult
    services/                    SnippetDataSource (contract), SnippetRestApi, ApiException
    snippet_list/                SnippetListPage (loads and shows the list), SnippetCard
test/
  snippet_library_app_test.dart  Starts the app with a fake data source, checks the page text
  snippets/models/               Unit tests for the models
  snippets/services/             FakeSnippetDataSource, used by the widget tests
  snippets/snippet_list/         Widget tests for the page states and the card
android/                         Generated Android project (not used yet)
web/                             Generated web host page (index.html, icons)
```

The layout follows the Vue app where Dart allows. Each class has its own file, named after it in snake_case. A widget and its private `State` class are the one exception, because Dart privacy works per file.

## How it works

`main()` creates a `SnippetRestApi` and calls `runApp` with `SnippetLibraryApp`, which passes the data source down to the page through constructors. `main` is the only place that knows which implementation is used. `SnippetLibraryApp` returns a `MaterialApp` whose first screen (`home`) is `SnippetListPage`.

Flutter draws its own UI on a canvas instead of using HTML elements, so the page in Chrome has no DOM elements to inspect.

### Loading snippets

`SnippetListPage` is a `StatefulWidget`. Its state starts one `getAll()` request in `initState` and keeps the resulting future, so a rebuild does not send the request again. A `FutureBuilder` draws the page from that future: a spinner while it runs, the message of the error if it failed (an `ApiException` shows the server's message, anything else shows "Could not reach the API"), "No snippets yet" for an empty result, and otherwise a `ListView.builder` of `SnippetCard`s.

The page talks to `SnippetDataSource`, not to a specific transport. `SnippetRestApi.getAll` builds `GET /snippets` with the optional `search`, `page` and `limit` parameters, checks the status, decodes the JSON and returns a `FindSnippetsResult`. If the API answers with an error, it throws an `ApiException` whose message is the server's `message`. Express sends that as text. NestJS may send a list, which is joined with `; `. If the body has no usable message, the text is "Failed to load snippets (status)".

## Notes

- The red DEBUG ribbon is hidden with `debugShowCheckedModeBanner: false`. Debug mode itself is still slower than a release build.
- The Express API allows requests only from `http://localhost:5173`, and the NestJS API only from `http://localhost:4200`, so the app is run in Chrome with `--web-port` set to match the API in use.
- Hot reload (`r`) does not start the request again, because it runs in `initState`. Use a hot restart (`R`) or refresh the browser tab.
- An empty search result reports page 1 of 0 pages.

## Roadmap

- GraphQL as a second transport, switched with one setting, as in the Vue and Angular apps.
- Search and pagination.
- Create, edit and delete.
- Running on an Android emulator.
