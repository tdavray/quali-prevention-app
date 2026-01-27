import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:quali_prevention_app/common/constant.dart';
import 'package:quali_prevention_app/common/model/prospect_model.dart';

class ProspectService {
  static const String baseUrl = AppConstants.apiBaseUrl;
  final _storage = const FlutterSecureStorage();

  // Méthode pour créer un nouveau prospect
  Future<bool> createProspect(Prospect prospect) async {
    String? token = await _storage.read(key: 'access_token');
    debugPrint('createProspect: payload=${json.encode(prospect.toJson())}');
    if (token == null || token.isEmpty) {
      debugPrint('createProspect: missing access_token');
    }

    try {
      final url = Uri.parse('$baseUrl/api/clients/prospect');
      final response = await http.post(
        url,
        headers: {
          if (token != null && token.isNotEmpty)
            'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(prospect.toJson()),
      );

      debugPrint('createProspect: status=${response.statusCode}');
      debugPrint('createProspect: body=${response.body}');
      debugPrint('createProspect: headers=${response.headers}');

      return response.statusCode == 201;
    } catch (e, s) {
      debugPrint('createProspect: exception=$e');
      debugPrint('createProspect: stack=$s');
      return false;
    }
  }
}
