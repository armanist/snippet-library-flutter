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

    return FindSnippetsResult.fromJson(_dataFrom(response));
  }

  Map<String, dynamic> _dataFrom(http.Response response) {
    final body = _decode(response.body);

    if (response.statusCode < 200 ||
        response.statusCode >= 300 ||
        body == null) {
      final message =
          _messageFrom(body) ??
          'Failed to load snippets (${response.statusCode})';

      throw ApiException(message);
    }

    return body;
  }

  String? _messageFrom(Map<String, dynamic>? body) {
    final message = body?['message'];

    if (message is String) return message;
    if (message is List) return message.join('; ');

    return null;
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
