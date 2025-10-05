import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:quali_prevention_app/common/constant.dart';
import 'package:quali_prevention_app/common/model/user_model.dart';

class AuthService {
  // Base URL for the authentication service
  static const String baseUrl = 'https://crm.quali-prevention.fr';

  // Secure storage instance
  final _storage = const FlutterSecureStorage();

  // In-memory token for simulator fallback
  String? _simulatedToken;

  // Determines if the app is running on a simulator
  bool get _isSimulator {
    return false;
  }

  Future<String?> getAccessToken(String username, String password) async {
    final url = Uri.parse('$baseUrl/oauth/token');
    final response = await http.post(
      url,
      body: {
        'grant_type': 'password',
        'username': username,
        'password': password,
        'client_id': AppConstants.clientId,
        'client_secret': AppConstants.clientSecret,
      },
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final String token = data['access_token'];

      if (_isSimulator) {
        _simulatedToken = token;
      } else {
        await _storage.write(key: 'access_token', value: token);
      }

      return token;
    } else {
      print('Erreur lors de la récupération du token: ${response.body}');
      return null;
    }
  }

  Future<String?> getSavedToken() async {
    if (_isSimulator) {
      return _simulatedToken;
    }
    return await _storage.read(key: 'access_token');
  }

  Future<void> logout() async {
    if (_isSimulator) {
      _simulatedToken = null;
    } else {
      await _storage.delete(key: 'access_token');
    }
  }

  Future<bool> createUser(CreateUser createUser) async {
    final url = Uri.parse('$baseUrl/api/users');
    final response = await http.post(
      url,
      body: json.encode(createUser.toJson()),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    print(json.encode(createUser.toJson()));

    if (response.statusCode == 201) {
      final token = await getAccessToken(createUser.email, createUser.password);
      return token != null;
    } else {
      print(response.statusCode);
      return false;
    }
  }
}
