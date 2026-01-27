import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:quali_prevention_app/common/constant.dart';
import 'package:quali_prevention_app/common/model/prospect_model.dart';

class ProspectResult {
  final bool success;
  final String message;

  const ProspectResult({required this.success, required this.message});
}

class ProspectService {
  static const String baseUrl = AppConstants.apiBaseUrl;
  final _storage = const FlutterSecureStorage();

  // Méthode pour créer un nouveau prospect
  Future<ProspectResult> createProspect(Prospect prospect) async {
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
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode(prospect.toJson()),
      );

      debugPrint('createProspect: status=${response.statusCode}');
      debugPrint('createProspect: body=${response.body}');
      debugPrint('createProspect: headers=${response.headers}');

      if (response.statusCode == 201) {
        return const ProspectResult(
          success: true,
          message: 'Prospect ajouté avec succès',
        );
      }

      return ProspectResult(
        success: false,
        message: _extractErrorMessage(response),
      );
    } catch (e, s) {
      debugPrint('createProspect: exception=$e');
      debugPrint('createProspect: stack=$s');
      return const ProspectResult(
        success: false,
        message: 'Erreur lors de l\'ajout du prospect. Veuillez réessayer.',
      );
    }
  }

  String _extractErrorMessage(http.Response response) {
    try {
      final body = json.decode(response.body);
      if (body is Map<String, dynamic>) {
        final errors = body['errors'];
        if (errors is Map<String, dynamic>) {
          for (final entry in errors.entries) {
            final value = entry.value;
            if (value is List && value.isNotEmpty) {
              return value.first.toString();
            }
          }
        }
        final message = body['message'];
        if (message is String && message.trim().isNotEmpty) {
          return message;
        }
      }
    } catch (_) {
      // Ignore JSON parse errors
    }

    return 'Erreur lors de l\'ajout du prospect (code ${response.statusCode}).';
  }
}
