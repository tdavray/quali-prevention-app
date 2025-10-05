class Section {
  String name;
  String icon;
  String? contentTitle;
  String contentBody;
  String? picture;

  Section({
    required this.name,
    required this.icon,
    this.contentTitle,
    required this.contentBody,
    this.picture,
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      name: json['name'],
      icon: json['icon'],
      contentTitle: json['contentTitle'],
      contentBody: json['contentBody'],
      picture: json['picture'],
    );
  }
}
