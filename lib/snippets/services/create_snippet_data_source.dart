import 'package:snippet_library_flutter/api_config.dart';
import 'package:snippet_library_flutter/snippets/services/snippet_data_source.dart';
import 'package:snippet_library_flutter/snippets/services/snippet_graphql_api.dart';
import 'package:snippet_library_flutter/snippets/services/snippet_rest_api.dart';

SnippetDataSource createSnippetDataSource() {
  return snippetTransport == 'graphql' ? SnippetGraphqlApi() : SnippetRestApi();
}
