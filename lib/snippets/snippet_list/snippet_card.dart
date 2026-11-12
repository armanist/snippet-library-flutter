import 'package:flutter/material.dart';
import 'package:snippet_library_flutter/snippets/models/snippet.dart';

class SnippetCard extends StatelessWidget {
  final Snippet snippet;

  const SnippetCard({super.key, required this.snippet});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(snippet.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(snippet.language),
            Text(
              snippet.code,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontFamily: 'monospace'),
            ),
            Wrap(
              spacing: 8,
              children: snippet.tags
                  .map((tag) => Chip(label: Text(tag)))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
