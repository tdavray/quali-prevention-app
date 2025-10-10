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
      id: json['id'] is int
          ? json['id'] as int
          : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      firstName: (json['first_name'] ?? '').toString(),
      lastName: (json['last_name'] ?? '').toString(),
      createdAt: (json['created_at'] ?? '').toString(),
      picture: (json['picture'] ?? '').toString(),
      statutName: (json['statut_name'] ?? '').toString(),
      domain: (json['domain']?.toString().isEmpty ?? true)
          ? null
          : json['domain'].toString(),
      consomationAnuelle:
          (json['consomation_anuelle']?.toString().isEmpty ?? true)
              ? null
              : json['consomation_anuelle'].toString(),
      credits: (json['credits']?.toString().isEmpty ?? true)
          ? null
          : json['credits'].toString(),
      commission: json['commission'] is num
          ? json['commission'] as num
          : num.tryParse(json['commission']?.toString() ?? ''),
      dateInstallation: (json['date_installation']?.toString().isEmpty ?? true)
          ? null
          : json['date_installation'].toString(),
      projectAdvancement: json['project_advancement'] is int
          ? json['project_advancement'] as int
          : int.tryParse(json['project_advancement']?.toString() ?? ''),
      montant: (json['montant']?.toString().isEmpty ?? true)
          ? null
          : json['montant'].toString(),
      formation: (json['formation']?.toString().isEmpty ?? true)
          ? null
          : json['formation'].toString(),
    );
  }
}
