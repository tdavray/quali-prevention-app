import 'package:quali_prevention_app/common/constant.dart';

class Product {
  final int id;
  final String name;
  final String icon;
  final String description;
  final String? descriptionImage;
  final String synthesis;
  final String? synthesisImage;
  final String? createdAt;
  final String? updatedAt;

  Product({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
    this.descriptionImage,
    required this.synthesis,
    this.synthesisImage,
    this.createdAt,
    this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    String _resolvePath(dynamic rawPath) {
      final value = (rawPath ?? '').toString();
      if (value.isEmpty) {
        return '';
      }

      final uri = Uri.tryParse(value);
      if (uri != null && uri.hasScheme) {
        return value;
      }

      return Uri.parse(AppConstants.apiBaseUrl).resolve(value).toString();
    }

    String? _resolveOptionalPath(dynamic rawPath) {
      final resolved = _resolvePath(rawPath);
      return resolved.isEmpty ? null : resolved;
    }

    return Product(
      id: json['id'] is int
          ? json['id'] as int
          : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      name: (json['name'] ?? '').toString(),
      icon: _resolvePath(json['icon']),
      description: (json['description'] ?? '').toString(),
      descriptionImage: _resolveOptionalPath(json['description_image']),
      synthesis: (json['synthesis'] ?? '').toString(),
      synthesisImage: _resolveOptionalPath(json['synthesis_image']),
      createdAt: (json['created_at'] ?? '').toString().isEmpty
          ? null
          : (json['created_at'] ?? '').toString(),
      updatedAt: (json['updated_at'] ?? '').toString().isEmpty
          ? null
          : (json['updated_at'] ?? '').toString(),
    );
  }
}
