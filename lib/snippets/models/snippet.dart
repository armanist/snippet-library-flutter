class Snippet {
  final String id;
  final String title;
  final String language;
  final String code;
  final List<String> tags;
  final DateTime createdAt;

  Snippet({
    required this.id,
    required this.title,
    required this.language,
    required this.code,
    required this.tags,
    required this.createdAt,
  });

  factory Snippet.fromJson(Map<String, dynamic> json) {
    return Snippet(
      id: json['id'] as String,
      title: json['title'] as String,
      language: json['language'] as String,
      code: json['code'] as String,
      tags: List<String>.from(json['tags'] as List),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}
