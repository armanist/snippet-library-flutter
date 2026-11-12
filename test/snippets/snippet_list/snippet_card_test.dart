import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snippet_library_flutter/snippets/models/snippet.dart';
import 'package:snippet_library_flutter/snippets/snippet_list/snippet_card.dart';

void main() {
  testWidgets('shows the title, language, code and tags', (tester) async {
    final snippet = Snippet(
      id: '1',
      title: 'join function',
      language: 'php',
      code: 'implode(", ", \$items)',
      tags: ['string', 'array'],
      createdAt: DateTime.utc(2026, 11, 5),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: SnippetCard(snippet: snippet)),
      ),
    );

    expect(find.text('join function'), findsOneWidget);

    expect(find.text('php'), findsOneWidget);

    expect(find.text('implode(", ", \$items)'), findsOneWidget);

    expect(find.text('string'), findsOneWidget);

    expect(find.text('array'), findsOneWidget);
  });
}
