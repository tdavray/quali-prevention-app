import 'dart:convert';
import 'dart:io'; // Import Platform class

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ShowForm {
  static const String baseUrl = 'https://crm.quali-prevention.fr';
  final _storage = const FlutterSecureStorage();

  Future<bool> getShowForm() async {
    // Check if the platform is Android
    if (Platform.isAndroid) {
      // Always return true on Android
      return true;
    }

    // For other platforms, proceed with the original logic
    String? token = await _storage.read(key: 'access_token');

    final url = Uri.parse('$baseUrl/api/show-form');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      print(data);

      String showForm = data['show_form'];

      if (showForm == '1') {
        return true;
      } else {
        return false;
      }
    } else {
      print('Erreur lors de la récupération du showForm: ${response.body}');
      return false;
    }
  }
}
