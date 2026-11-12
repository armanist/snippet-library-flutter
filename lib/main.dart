import 'package:flutter/material.dart';
import 'package:snippet_library_flutter/snippet_library_app.dart';
import 'package:snippet_library_flutter/snippets/services/snippet_rest_api.dart';

void main() {
  runApp(SnippetLibraryApp(dataSource: SnippetRestApi()));
}
