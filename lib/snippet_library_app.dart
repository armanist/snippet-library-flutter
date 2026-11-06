import 'package:flutter/material.dart';
import 'package:snippet_library_flutter/snippets/snippet_list/snippet_list_page.dart';

class SnippetLibraryApp extends StatelessWidget {
  const SnippetLibraryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Snippet Library',
      home: SnippetListPage(),
    );
  }
}
