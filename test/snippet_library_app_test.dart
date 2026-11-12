import 'package:flutter_test/flutter_test.dart';
import 'package:snippet_library_flutter/snippet_library_app.dart';
import 'package:snippet_library_flutter/snippets/models/find_snippets_result.dart';
import 'package:snippet_library_flutter/snippets/models/pagination_metadata.dart';

import 'snippets/services/fake_snippet_data_source.dart';

void main() {
  testWidgets('shows the empty snippet list page', (tester) async {
    final dataSource = FakeSnippetDataSource(
      () => Future.value(
        FindSnippetsResult(
          snippets: [],
          pagination: PaginationMetadata(
            page: 1,
            limit: 20,
            total: 0,
            totalPages: 0,
          ),
        ),
      ),
    );

    await tester.pumpWidget(SnippetLibraryApp(dataSource: dataSource));
    await tester.pumpAndSettle();

    expect(find.text('Snippet Library'), findsOneWidget);
    expect(find.text('No snippets yet'), findsOneWidget);
  });
}
