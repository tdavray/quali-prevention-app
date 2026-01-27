import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:quali_prevention_app/common/constant.dart';
import 'package:quali_prevention_app/common/helper.dart';
import 'package:quali_prevention_app/common/model/client_model.dart';
import 'package:quali_prevention_app/common/model/user_model.dart';
import 'package:quali_prevention_app/common/model/user_network.dart';

class UserService {
  static const String baseUrl = AppConstants.apiBaseUrl;
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

        DateTime parseKey(String key) {
          final parts = key.split('/');
          if (parts.length != 2) {
            return DateTime(1970, 1);
          }

          final month = int.tryParse(parts[0]) ?? 1;
          final yearPart = int.tryParse(parts[1]) ?? 0;
          final year = yearPart < 100 ? 2000 + yearPart : yearPart;
          return DateTime(year, month);
        }

        result.sort((a, b) {
          final dateA = parseKey(a.keys.first);
          final dateB = parseKey(b.keys.first);
          return dateB.compareTo(dateA);
        });

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
      final dynamic decoded = json.decode(response.body);

      // Handle both List and Map responses
      List<dynamic> clients;
      if (decoded is List) {
        clients = decoded;
      } else if (decoded is Map) {
        // If it's a map, try to extract the list from it
        // or convert map values to a list
        if (decoded.containsKey('data')) {
          clients = decoded['data'] as List<dynamic>;
        } else {
          // If the map contains client objects directly, convert values to list
          clients = decoded.values.toList();
        }
      } else {
        return [];
      }

      if (clients.isNotEmpty) {
        return clients
            .whereType<Map<String, dynamic>>()
            .map((client) => Client.fromJson(client))
            .toList();
      }

      return [];
    } else {
      print('Erreur lors de la récupération des clients: ${response.body}');
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
      final dynamic decoded = json.decode(response.body);

      // Handle both List and Map responses
      List<dynamic> networkData;
      if (decoded is List) {
        networkData = decoded;
      } else if (decoded is Map) {
        if (decoded.containsKey('data')) {
          networkData = decoded['data'] as List<dynamic>;
        } else {
          networkData = decoded.values.toList();
        }
      } else {
        return [];
      }

      // Convert the response to a list of UserNetwork objects
      return networkData
          .whereType<Map<String, dynamic>>()
          .map((networkItem) => UserNetwork.fromJson(networkItem))
          .toList();
    } else {
      print(
          'Erreur lors de la récupération du réseau utilisateur: ${response.body}');
      return [];
    }
  }
}
