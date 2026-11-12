import 'package:flutter/material.dart';
import 'package:snippet_library_flutter/snippets/services/snippet_data_source.dart';
import 'package:snippet_library_flutter/snippets/snippet_list/snippet_list_page.dart';

class SnippetLibraryApp extends StatelessWidget {
  final SnippetDataSource dataSource;

  const SnippetLibraryApp({super.key, required this.dataSource});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Snippet Library',
      home: SnippetListPage(dataSource: dataSource),
    );
  }
}
