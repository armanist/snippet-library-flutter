import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:snippet_library_flutter/api_config.dart';
import 'package:snippet_library_flutter/snippets/graphql/snippet_queries.dart';
import 'package:snippet_library_flutter/snippets/models/find_snippets_result.dart';
import 'package:snippet_library_flutter/snippets/services/api_exception.dart';
import 'package:snippet_library_flutter/snippets/services/snippet_data_source.dart';

class SnippetGraphqlApi implements SnippetDataSource {
  @override
  Future<FindSnippetsResult> getAll({
    String? search,
    int? page,
    int? limit,
  }) async {
    final response = await http.post(
      Uri.parse('$apiBaseUrl/graphql'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'query': getSnippetsQuery,
        'variables': {'search': search, 'page': page, 'limit': limit},
      }),
    );

    final data = _dataFrom(response);

    return FindSnippetsResult.fromJson(
      data['snippets'] as Map<String, dynamic>,
    );
  }

  Map<String, dynamic> _dataFrom(http.Response response) {
    final body = _decode(response.body);
    final data = body?['data'];

    if (response.statusCode < 200 ||
        response.statusCode >= 300 ||
        data is! Map<String, dynamic>) {
      final message =
          _messageFrom(body) ??
          'Failed to load snippets (${response.statusCode})';

      throw ApiException(message);
    }

    return data;
  }

  String? _messageFrom(Map<String, dynamic>? body) {
    final errors = body?['errors'];

    if (errors is! List || errors.isEmpty) {
      return null;
    }

    return errors.map((error) => error['message']).join('; ');
  }

  Map<String, dynamic>? _decode(String text) {
    try {
      final decoded = jsonDecode(text);

      return decoded is Map<String, dynamic> ? decoded : null;
    } on FormatException {
      return null;
    }
  }
}
