const getSnippetsQuery = r'''
  query GetSnippets($search: String, $page: Int, $limit: Int) {
    snippets(search: $search, page: $page, limit: $limit) {
      snippets {
        id
        title
        language
        code
        tags
        createdAt
      }
      pagination {
        page
        limit
        total
        totalPages
      }
    }
  }
''';
