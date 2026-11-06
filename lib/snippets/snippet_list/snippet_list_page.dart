import 'package:flutter/material.dart';

class SnippetListPage extends StatelessWidget {
  const SnippetListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Snippet Library')),
      body: const Center(child: Text('No snippets yet')),
    );
  }
}
