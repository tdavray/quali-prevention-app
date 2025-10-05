import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sdm_academy_app/common/helper.dart';
import 'package:sdm_academy_app/common/model/client_model.dart';
import 'package:sdm_academy_app/common/model/user_model.dart';
import 'package:sdm_academy_app/common/model/user_network.dart';

class UserService {
  static const String baseUrl = 'https://crm.mybeeacademy-sdm.fr';
  final _storage = const FlutterSecureStorage();

  Future<User?> getUserProfile() async {
    String? token = await _storage.read(key: 'access_token');

    final url = Uri.parse('$baseUrl/api/user/profile');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return User.fromJson(data);
    } else {
      print(
          'Erreur lors de la récupération du profil utilisateur: ${response.body}');
      return null;
    }
  }

  Future<void> updateUserProfile(User user) async {
    String? token = await _storage.read(key: 'access_token');

    final url = Uri.parse('$baseUrl/user/profile');
    final response = await http.put(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(user.toJson()),
    );

    if (response.statusCode != 200) {
      print(
          'Erreur lors de la mise à jour du profil utilisateur: ${response.body}');
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: 'access_token');
  }

  Future<String?> getUserCA({String? params}) async {
    String? token = await _storage.read(key: 'access_token');

    final url = Uri.parse('$baseUrl/api/user/ca${params ?? ''}');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data.isNotEmpty) {
        final key = data.keys.first;
        final value = data[key]?.toDouble();

        if (value != null) {
          return formatCurrency(value);
        }
      }
      return null;
    } else {
      print('Erreur lors de la récupération du CA: ${response.body}');
      return null;
    }
  }

  Future<String?> getCurrentMonthUserCommissions() async {
    String? token = await _storage.read(key: 'access_token');

    final url = Uri.parse('$baseUrl/api/user/commissions?month=current');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data.isNotEmpty) {
        final key = data.keys.first;
        final value = data[key]?.toDouble();

        if (value != null) {
          return formatCurrency(value);
        }
      }
      return null;
    } else {
      print(
          'Erreur lors de la récupération  de la commission: ${response.body}');
      return null;
    }
  }

  Future<List<Map<String, int>>> getAllUserCommissions() async {
    String? token = await _storage.read(key: 'access_token');

    final url = Uri.parse('$baseUrl/api/user/commissions');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data.isNotEmpty) {
        // Convert the Map to a List of Maps
        List<Map<String, int>> result = data.entries.map((entry) {
          return {entry.key: (entry.value as num).round()};
        }).toList();

        return result;
      }
      return [];
    } else {
      print('Erreur lors de la récupération des commissions: ${response.body}');
      return [];
    }
  }

  Future<Map<String, int>?> getUserClientsByStatus({String? params}) async {
    String? token = await _storage.read(key: 'access_token');

    final url = Uri.parse('$baseUrl/api/user/clients-by-status${params ?? ''}');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data.isNotEmpty) {
        final key = data.keys.first;
        final value = data[key];

        if (value is Map<String, dynamic>) {
          return value.map((key, value) => MapEntry(key, value as int));
        }
      }
      return null;
    } else {
      print(
          'Erreur lors de la récupération des clients par statut: ${response.body}');
      return null;
    }
  }

  Future<List<Client>> getAllUserClients() async {
    String? token = await _storage.read(key: 'access_token');

    final url = Uri.parse('$baseUrl/api/user/clients');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> clients = json.decode(response.body);
      if (clients.isNotEmpty) {
        return clients
            .map((client) => Client.fromJson(client as Map<String, dynamic>))
            .toList();
      }

      return [];
    } else {
      print('Erreur lors de la récupération des commissions: ${response.body}');
      return [];
    }
  }

  Future<Client?> getClientById({required int clientId}) async {
    String? token = await _storage.read(key: 'access_token');

    final url = Uri.parse('$baseUrl/api/clients/$clientId/details');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> client = json.decode(response.body);
      return Client.fromJson(client);
    } else {
      print('Erreur lors de la récupération des commissions: ${response.body}');
      return null;
    }
  }

  Future<Map<String, int>?> getClientAmountByYear({required int year}) async {
    String? token = await _storage.read(key: 'access_token');

    final url = Uri.parse('$baseUrl/api/user/clients-amount?year=$year');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> client = json.decode(response.body);
      return client.map((key, value) => MapEntry(key, value as int));
    } else {
      print(
          'Erreur lors de la récupération des quantité de clients en $year: ${response.body}');
      return null;
    }
  }

  Future<List<UserNetwork>> getUserNetwork() async {
    String? token = await _storage.read(key: 'access_token');

    final url = Uri.parse('$baseUrl/api/user/network');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> networkData = json.decode(response.body);
      // Convert the response to a list of UserNetwork objects
      return networkData
          .map((networkItem) => UserNetwork.fromJson(networkItem))
          .toList();
    } else {
      print(
          'Erreur lors de la récupération du réseau utilisateur: ${response.body}');
      return [];
    }
  }
}
