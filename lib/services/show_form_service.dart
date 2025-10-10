import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:quali_prevention_app/common/constant.dart';

class ShowForm {
  static const String baseUrl = AppConstants.apiBaseUrl;
  final _storage = const FlutterSecureStorage();

  Future<bool> getShowForm() async {
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      // Android devices should always display the form according to business requirement.
      return true;
    }

    final token = await _storage.read(key: 'access_token');
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/show-form'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['show_form'].toString() == '1';
      }

      debugPrint(
        'Erreur lors de la récupération du showForm (${response.statusCode}): ${response.body}',
      );
    } catch (error, stackTrace) {
      debugPrint('Exception lors de la récupération du showForm: $error');
      debugPrint(stackTrace.toString());
    }

    return false;
  }
}
