import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:quali_prevention_app/common/model/news_model.dart';

class NewsService {
  static const String baseUrl = 'https://crm.mybeeacademy-sdm.fr';
  final _storage = const FlutterSecureStorage();

  Future<List<News>?> getNewsArticles({int page = 1, int perPage = 4}) async {
    String? token = await _storage.read(key: 'access_token');

    final url = Uri.parse('$baseUrl/api/news?page=$page&per_page=$perPage');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data.containsKey('data')) {
        List<News> articles = (data['data'] as List)
            .map((articleData) => News.fromJson(articleData))
            .toList();
        return articles;
      }
      return null;
    } else {
      print('Erreur lors de la récupération des articles: ${response.body}');
      return null;
    }
  }

  Future<News?> getArticleById({required int articleId}) async {
    String? token = await _storage.read(key: 'access_token');

    final url = Uri.parse('$baseUrl/api/news/$articleId');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> article = json.decode(response.body);
      return News.fromJson(article);
    } else {
      print(
          'Erreur lors de la récupération de l\'article $articleId: ${response.body}');
      return null;
    }
  }

  Future<News?> getFeaturedArticle() async {
    String? token = await _storage.read(key: 'access_token');

    final url = Uri.parse('$baseUrl/api/news/featured');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> article = json.decode(response.body);
      return News.fromJson(article);
    } else {
      print(
          'Erreur lors de la récupération de l\'article en avant: ${response.body}');
      return null;
    }
  }
}
