import 'package:snippet_library_flutter/snippets/models/find_snippets_result.dart';

abstract interface class SnippetDataSource {
  Future<FindSnippetsResult> getAll({String? search, int? page, int? limit});
}
