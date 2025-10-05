class Product {
  int id;
  String name;
  String? icon;
  String? titleFonctionnement;
  String? descriptionFonctionnement;
  String? imageFonctionnement;
  String? titleReferences;
  String? descriptionReferences;
  String? imageReferences;
  String? titlePrix;
  String? descriptionPrix;
  String? imagePrix;
  String? titleArguments;
  String? descriptionArguments;
  String? imageArguments;
  String? createdAt;
  String? updatedAt;

  Product({
    required this.id,
    required this.name,
    this.icon,
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
    this.createdAt,
    this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
      titleFonctionnement: json['title_fonctionnement'],
      descriptionFonctionnement: json['description_fonctionnement'],
      imageFonctionnement: json['image_fonctionnement'],
      titleReferences: json['title_references'],
      descriptionReferences: json['description_references'],
      imageReferences: json['image_references'],
      titlePrix: json['title_prix'],
      descriptionPrix: json['description_prix'],
      imagePrix: json['image_prix'],
      titleArguments: json['title_arguments'],
      descriptionArguments: json['description_arguments'],
      imageArguments: json['image_arguments'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
