import 'package:flutter_test/flutter_test.dart';
import 'package:snippet_library_flutter/snippet_library_app.dart';

void main() {
  testWidgets('shows the empty snippet list page', (tester) async {
    await tester.pumpWidget(const SnippetLibraryApp());

    expect(find.text('Snippet Library'), findsOneWidget);
    expect(find.text('No snippets yet'), findsOneWidget);
  });
}
