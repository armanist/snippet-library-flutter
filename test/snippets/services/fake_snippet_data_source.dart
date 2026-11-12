import 'package:snippet_library_flutter/snippets/models/find_snippets_result.dart';
import 'package:snippet_library_flutter/snippets/services/snippet_data_source.dart';

class FakeSnippetDataSource implements SnippetDataSource {
  final Future<FindSnippetsResult> Function() response;

  FakeSnippetDataSource(this.response);

  @override
  Future<FindSnippetsResult> getAll({String? search, int? page, int? limit}) {
    return response();
  }
}
