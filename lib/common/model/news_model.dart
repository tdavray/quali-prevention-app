class News {
  final int id;
  final String title;
  final String image;
  String? description;
  final String shortDescription;
  final DateTime createdAt;
  final DateTime updatedAt;

  News({
    required this.id,
    required this.title,
    required this.image,
    this.description,
    required this.shortDescription,
    required this.createdAt,
    required this.updatedAt,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      description: json['description'] ?? '',
      shortDescription: json['short_description'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
