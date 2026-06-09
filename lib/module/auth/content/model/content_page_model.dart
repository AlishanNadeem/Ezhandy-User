class ContentPage {
  final String id;
  final String slug;
  final String title;
  final String content;
  final String updatedAt;

  ContentPage({
    required this.id,
    required this.slug,
    required this.title,
    required this.content,
    required this.updatedAt,
  });

  factory ContentPage.fromJson(Map<String, dynamic> json) {
    return ContentPage(
      id: json['id']?.toString() ?? '',
      slug: json['slug']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      content: json['content']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString() ?? '',
    );
  }
}
