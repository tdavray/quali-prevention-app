class User {
  final String name;
  final String picture;

  User({
    required this.name,
    required this.picture,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      picture: json['picture'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'picture': picture,
    };
  }
}

class CreateUser {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNo;
  /*final String firstAddress;
  final String city;
  final String zip;*/
  final String matricule;
  /*final String company;
  final String activite;*/
  final String password;

  CreateUser({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNo,
    /*required this.firstAddress,
    required this.city,
    required this.zip,*/
    required this.matricule,
    /*required this.company,
    required this.activite,*/
    required this.password,
  });

  factory CreateUser.fromJson(Map<String, dynamic> json) {
    return CreateUser(
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phoneNo: json['phoneNo'],
      /*firstAddress: json['first_address'],
      city: json['city'],
      zip: json['zip'],*/
      matricule: json['matricule'],
      /*company: json['company'],
      activite: json['activite'],*/
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phoneNo': phoneNo,
      /*'first_address': firstAddress,
      'city': city,
      'zip': zip,*/
      'matricule': matricule,
      /*'company': company,
      'activite': activite,*/
      'password': password,
    };
  }
}
