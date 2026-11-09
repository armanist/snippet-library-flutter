import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:snippet_library_flutter/api_config.dart';
import 'package:snippet_library_flutter/snippets/models/find_snippets_result.dart';
import 'package:snippet_library_flutter/snippets/services/api_exception.dart';
import 'package:snippet_library_flutter/snippets/services/snippet_data_source.dart';

class SnippetRestApi implements SnippetDataSource {
  @override
  Future<FindSnippetsResult> getAll({
    String? search,
    int? page,
    int? limit,
  }) async {
    final queryParameters = <String, String>{};

    if (search != null) queryParameters['search'] = search;
    if (page != null) queryParameters['page'] = page.toString();
    if (limit != null) queryParameters['limit'] = limit.toString();

    final url = Uri.parse('$apiBaseUrl/snippets')
        .replace(queryParameters: queryParameters);

    final response = await http.get(url);

    _throwIfFailed(response, 'Failed to load snippets');

    return FindSnippetsResult.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }

  void _throwIfFailed(http.Response response, String fallbackMessage) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return;
    }

    throw ApiException(
      _messageFrom(response) ?? '$fallbackMessage (${response.statusCode})',
    );
  }

  String? _messageFrom(http.Response response) {
    try {
      final body = jsonDecode(response.body);
      final message = body is Map<String, dynamic> ? body['message'] : null;

      if (message is String) return message;
      if (message is List) return message.join('; ');
    } on FormatException {
      return null;
    }

    return null;
  }
}
