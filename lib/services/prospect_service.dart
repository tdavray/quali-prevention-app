import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:quali_prevention_app/common/model/prospect_model.dart';

class ProspectService {
  static const String baseUrl = 'https://crm.mybeeacademy-sdm.fr';
  final _storage = const FlutterSecureStorage();

  // Méthode pour créer un nouveau prospect
  Future<bool> createProspect(Prospect prospect) async {
    String? token = await _storage.read(key: 'access_token');

    log(json.encode(prospect.toJson()));
    log(prospect.toJson().toString());

    final url = Uri.parse('$baseUrl/api/clients');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(prospect.toJson()),
    );

    if (response.statusCode == 201) {
      return true;
    } else if (response.statusCode >= 300 && response.statusCode < 400) {
      return false;
    } else {
      return false;
    }
  }
}
