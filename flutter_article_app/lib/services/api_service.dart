// Handles API calls
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article.dart';

class ApiService {
  static const _baseUrl = 'https://jsonplaceholder.typicode.com';

  // Fetches a list of articles from the API
  Future<List<Article>> fetchArticles() async {
    final response = await http.get(Uri.parse('$_baseUrl/posts'));

    // If successful response
    if (response.statusCode == 200) {
      final List data = json.decode(response.body); // Decode JSON array
      return data
          .map((json) => Article.fromJson(json))
          .toList(); // Map to list of Article objects
    } else {
      // Throw error if request fails
      throw Exception('Failed to load articles');
    }
  }
}
