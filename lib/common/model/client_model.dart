class Client {
  int id;
  String firstName;
  String lastName;
  String createdAt;
  String picture;
  String statutName;
  String? domain;
  String? consomationAnuelle;
  String? credits;
  num? commission;
  String? dateInstallation;
  int? projectAdvancement;
  String? montant;
  String? formation;

  Client({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.createdAt,
    required this.picture,
    required this.statutName,
    required this.domain,
    required this.consomationAnuelle,
    this.credits,
    required this.commission,
    this.dateInstallation,
    required this.projectAdvancement,
    this.montant,
    this.formation,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      createdAt: json['created_at'],
      picture: json['picture'],
      statutName: json['statut_name'],
      domain: json['domain'],
      consomationAnuelle: json['consomation_anuelle'],
      credits: json['credits'],
      commission: json['commission'],
      dateInstallation: json['date_installation'],
      projectAdvancement: json['project_advancement'],
      montant: json['montant'],
      formation: json['formation'],
    );
  }
}
