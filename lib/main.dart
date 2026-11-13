import 'package:flutter/material.dart';
import 'package:snippet_library_flutter/snippet_library_app.dart';
import 'package:snippet_library_flutter/snippets/services/create_snippet_data_source.dart';

void main() {
  runApp(SnippetLibraryApp(dataSource: createSnippetDataSource()));
}
