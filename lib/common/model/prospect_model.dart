class Prospect {
  String civility;
  String firstName;
  String lastName;
  String email;
  String mobilePhone;
  /*String address;
  String postalCode;
  String city;*/
  String comment;
  /*int surface;
  int typeChauffage; // 1: Electrique, 2: Bois, 3: Gaz, 4: PAC
  int factureParAn;*/

  Prospect({
    required this.civility,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobilePhone,
    /*required this.address,
    required this.postalCode,
    required this.city,*/
    required this.comment,
    /*required this.surface,
    required this.typeChauffage,
    required this.factureParAn,*/
  });

  Map<String, dynamic> toJson() {
    return {
      'civility': civility,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'mobile_phone': mobilePhone,
      /*'address': address,
      'postal_code': postalCode,
      'city': city,*/
      'comment': comment,
      /*'surface': surface,
      'type_chauffage': typeChauffage,
      'facture_par_an': factureParAn,*/
    };
  }
}
