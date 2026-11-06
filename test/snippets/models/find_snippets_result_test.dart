import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:snippet_library_flutter/snippets/models/find_snippets_result.dart';

const _listResponse = '''
{
  "snippets": [
    {
      "id": "c7b59e97-ca01-4f87-a7d3-f61ea7e8c290",
      "title": "join function",
      "language": "javascript",
      "code": "join()",
      "tags": ["join"],
      "createdAt": "2026-11-05T10:17:44.000Z"
    },
    {
      "id": "baa6ff15-f610-4adb-931c-65d02ec6710a",
      "title": "GraphQL mutation test",
      "language": "typescript",
      "code": "const answer: number = 42",
      "tags": ["graphql", "express"],
      "createdAt": "2026-10-07T17:43:33.000Z"
    }
  ],
  "pagination": {"page": 1, "limit": 2, "total": 7, "totalPages": 4}
}
''';

void main() {
  test('parses the response', () {
    final result = FindSnippetsResult.fromJson(
      jsonDecode(_listResponse) as Map<String, dynamic>,
    );

    expect(result.snippets, hasLength(2));

    expect(result.snippets[0].title, 'join function');

    expect(result.pagination.totalPages, 4);
  });
}
