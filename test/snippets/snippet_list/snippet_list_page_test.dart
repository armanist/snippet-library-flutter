import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snippet_library_flutter/snippets/models/find_snippets_result.dart';
import 'package:snippet_library_flutter/snippets/models/pagination_metadata.dart';
import 'package:snippet_library_flutter/snippets/models/snippet.dart';
import 'package:snippet_library_flutter/snippets/services/api_exception.dart';
import 'package:snippet_library_flutter/snippets/snippet_list/snippet_card.dart';
import 'package:snippet_library_flutter/snippets/snippet_list/snippet_list_page.dart';

import '../services/fake_snippet_data_source.dart';

void main() {
  testWidgets('shows a spinner while the snippets load', (tester) async {
    await _pumpPage(tester, () => Completer<FindSnippetsResult>().future);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows the message of an API error', (tester) async {
    await _pumpPage(
      tester,
      () => Future.error(ApiException('Failed to load snippets (500)')),
    );

    await tester.pumpAndSettle();

    expect(find.text('Failed to load snippets (500)'), findsOneWidget);
  });

  testWidgets('shows a fixed message when the API is unreachable', (
    tester,
  ) async {
    await _pumpPage(
      tester,
      () => Future.error(Exception('connection refused')),
    );
    await tester.pumpAndSettle();

    expect(find.text('Could not reach the API'), findsOneWidget);
  });

  testWidgets('shows a card for each snippet', (tester) async {
    await _pumpPage(
      tester,
      () => Future.value(
        _resultOf([
          Snippet(
            id: '1',
            title: 'join function',
            language: 'php',
            code: 'implode(", ", \$items)',
            tags: ['string'],
            createdAt: DateTime.utc(2026, 11, 5),
          ),
          Snippet(
            id: '2',
            title: 'sort array',
            language: 'javascript',
            code: 'items.sort()',
            tags: ['array'],
            createdAt: DateTime.utc(2026, 11, 6),
          ),
        ]),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(SnippetCard), findsNWidgets(2));

    expect(find.text('join function'), findsOneWidget);

    expect(find.text('sort array'), findsOneWidget);
  });

  testWidgets('shows a message when there are no snippets', (tester) async {
    await _pumpPage(tester, () => Future.value(_resultOf([])));
    await tester.pumpAndSettle();

    expect(find.byType(SnippetCard), findsNothing);

    expect(find.text('No snippets yet'), findsOneWidget);
  });
}

Future<void> _pumpPage(
  WidgetTester tester,
  Future<FindSnippetsResult> Function() response,
) {
  return tester.pumpWidget(
    MaterialApp(
      home: SnippetListPage(dataSource: FakeSnippetDataSource(response)),
    ),
  );
}

FindSnippetsResult _resultOf(List<Snippet> snippets) {
  return FindSnippetsResult(
    snippets: snippets,
    pagination: PaginationMetadata(
      page: 1,
      limit: 20,
      total: snippets.length,
      totalPages: 1,
    ),
  );
}
