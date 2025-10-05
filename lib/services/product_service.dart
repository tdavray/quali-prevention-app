import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sdm_academy_app/common/model/product_model.dart';

class ProductService {
  static const String baseUrl = 'https://crm.mybeeacademy-sdm.fr';
  final _storage = const FlutterSecureStorage();

  Future<List<Product>?> getAllProducts() async {
    String? token = await _storage.read(key: 'access_token');

    final url = Uri.parse('$baseUrl/api/products');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      print(data);

      List<Product> products =
          data.map((productData) => Product.fromJson(productData)).toList();

      return products;
    } else {
      print('Erreur lors de la récupération des products: ${response.body}');
      return null;
    }
  }

  Future<Product?> getProductById({required int productId}) async {
    String? token = await _storage.read(key: 'access_token');

    final url = Uri.parse('$baseUrl/api/products/$productId');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> product = json.decode(response.body);
      return Product.fromJson(product);
    } else {
      print(
          'Erreur lors de la récupération du product $productId: ${response.body}');
      return null;
    }
  }
}
