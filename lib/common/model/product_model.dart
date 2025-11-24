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

  final String? titleFonctionnement;
  final String? descriptionFonctionnement;
  final String? imageFonctionnement;

  final String? titleReferences;
  final String? descriptionReferences;
  final String? imageReferences;

  final String? titlePrix;
  final String? descriptionPrix;
  final String? imagePrix;

  final String? titleArguments;
  final String? descriptionArguments;
  final String? imageArguments;

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
    this.titleFonctionnement,
    this.descriptionFonctionnement,
    this.imageFonctionnement,
    this.titleReferences,
    this.descriptionReferences,
    this.imageReferences,
    this.titlePrix,
    this.descriptionPrix,
    this.imagePrix,
    this.titleArguments,
    this.descriptionArguments,
    this.imageArguments,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    String resolvePath(dynamic rawPath) {
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

    String? resolveOptionalPath(dynamic rawPath) {
      final resolved = resolvePath(rawPath);
      return resolved.isEmpty ? null : resolved;
    }

    return Product(
      id: json['id'] is int
          ? json['id'] as int
          : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      name: (json['name'] ?? '').toString(),
      icon: resolvePath(json['icon']),
      description: (json['description'] ?? '').toString(),
      descriptionImage: resolveOptionalPath(json['description_image']),
      synthesis: (json['synthesis'] ?? '').toString(),
      synthesisImage: resolveOptionalPath(json['synthesis_image']),
      createdAt: (json['created_at'] ?? '').toString().isEmpty
          ? null
          : (json['created_at'] ?? '').toString(),
      updatedAt: (json['updated_at'] ?? '').toString().isEmpty
          ? null
          : (json['updated_at'] ?? '').toString(),
      titleFonctionnement:
          (json['title_fonctionnement'] ?? '').toString().isEmpty
              ? null
              : (json['title_fonctionnement'] ?? '').toString(),
      descriptionFonctionnement:
          (json['description_fonctionnement'] ?? '').toString().isEmpty
              ? null
              : (json['description_fonctionnement'] ?? '').toString(),
      imageFonctionnement: resolveOptionalPath(json['image_fonctionnement']),
      titleReferences: (json['title_references'] ?? '').toString().isEmpty
          ? null
          : (json['title_references'] ?? '').toString(),
      descriptionReferences:
          (json['description_references'] ?? '').toString().isEmpty
              ? null
              : (json['description_references'] ?? '').toString(),
      imageReferences: resolveOptionalPath(json['image_references']),
      titlePrix: (json['title_prix'] ?? '').toString().isEmpty
          ? null
          : (json['title_prix'] ?? '').toString(),
      descriptionPrix: (json['description_prix'] ?? '').toString().isEmpty
          ? null
          : (json['description_prix'] ?? '').toString(),
      imagePrix: resolveOptionalPath(json['image_prix']),
      titleArguments: (json['title_arguments'] ?? '').toString().isEmpty
          ? null
          : (json['title_arguments'] ?? '').toString(),
      descriptionArguments:
          (json['description_arguments'] ?? '').toString().isEmpty
              ? null
              : (json['description_arguments'] ?? '').toString(),
      imageArguments: resolveOptionalPath(json['image_arguments']),
    );
  }
}
