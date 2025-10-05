class UserNetwork {
  final String name;
  final String email;
  final Map<String, int> monthlyCommission;

  UserNetwork({
    required this.name,
    required this.email,
    required this.monthlyCommission,
  });

  factory UserNetwork.fromJson(Map<String, dynamic> json) {
    return UserNetwork(
      name: json['name'] as String,
      email: json['email'] as String,
      monthlyCommission: json['monthlyCommission'] is List &&
              (json['monthlyCommission'] as List).isEmpty
          ? {}
          : Map<String, int>.from(json['monthlyCommission']),
    );
  }
}
