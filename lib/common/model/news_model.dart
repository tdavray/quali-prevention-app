import 'package:quali_prevention_app/common/constant.dart';

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
    String resolveImagePath(dynamic rawPath) {
      final path = (rawPath ?? '').toString();
      if (path.isEmpty) {
        return '';
      }

      final uri = Uri.tryParse(path);
      if (uri != null && uri.hasScheme) {
        return path;
      }

      final baseUri = Uri.parse(AppConstants.apiBaseUrl);
      return baseUri.resolve(path).toString();
    }

    return News(
      id: json['id'] is int
          ? json['id'] as int
          : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      title: (json['title'] ?? '').toString(),
      image: resolveImagePath(json['image']),
      description: (json['description'] ?? '').toString(),
      shortDescription: (json['short_description'] ?? '').toString(),
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
      updatedAt: DateTime.tryParse(json['updated_at']?.toString() ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
    );
  }
}
