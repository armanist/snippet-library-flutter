import 'package:flutter/material.dart';
import 'package:snippet_library_flutter/snippets/models/find_snippets_result.dart';
import 'package:snippet_library_flutter/snippets/services/api_exception.dart';
import 'package:snippet_library_flutter/snippets/services/snippet_data_source.dart';
import 'package:snippet_library_flutter/snippets/snippet_list/snippet_card.dart';

class SnippetListPage extends StatefulWidget {
  final SnippetDataSource dataSource;

  const SnippetListPage({super.key, required this.dataSource});

  @override
  State<SnippetListPage> createState() => _SnippetListPageState();
}

class _SnippetListPageState extends State<SnippetListPage> {
  late final Future<FindSnippetsResult> _snippets;

  @override
  void initState() {
    super.initState();
    _snippets = widget.dataSource.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Snippet Library')),
      body: FutureBuilder<FindSnippetsResult>(
        future: _snippets,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            final error = snapshot.error;
            final message = error is ApiException
                ? error.message
                : 'Could not reach the API';

            return Center(child: Text(message));
          }

          final snippets = snapshot.requireData.snippets;

          if (snippets.isEmpty) {
            return const Center(child: Text('No snippets yet'));
          }

          return ListView.builder(
            itemCount: snippets.length,
            itemBuilder: (context, index) =>
                SnippetCard(snippet: snippets[index]),
          );
        },
      ),
    );
  }
}
