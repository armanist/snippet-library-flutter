import 'package:snippet_library_flutter/snippets/models/pagination_metadata.dart';
import 'package:snippet_library_flutter/snippets/models/snippet.dart';

class FindSnippetsResult {
  final List<Snippet> snippets;
  final PaginationMetadata pagination;

  FindSnippetsResult({required this.snippets, required this.pagination});

  factory FindSnippetsResult.fromJson(Map<String, dynamic> json) {
    return FindSnippetsResult(
      snippets: (json['snippets'] as List)
          .map((item) => Snippet.fromJson(item as Map<String, dynamic>))
          .toList(),
      pagination: PaginationMetadata.fromJson(
        json['pagination'] as Map<String, dynamic>,
      ),
    );
  }
}
