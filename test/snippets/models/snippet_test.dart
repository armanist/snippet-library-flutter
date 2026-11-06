import 'package:flutter_test/flutter_test.dart';
import 'package:snippet_library_flutter/snippets/models/snippet.dart';

void main() {
  test('builds a snippet from a map', () {
    final snippet = Snippet.fromJson({
      'id': 'a1',
      'title': 'Reverse a string',
      'language': 'php',
      'code': 'echo 1;',
      'tags': ['item1', 'item2'],
      'createdAt': '2026-11-05T10:00:00.000Z',
    });

    expect(snippet.title, 'Reverse a string');

    expect(snippet.tags, ['item1', 'item2']);

    expect(snippet.createdAt, DateTime.utc(2026, 11, 5, 10));
  });
}
