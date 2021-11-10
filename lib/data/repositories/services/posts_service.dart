import 'dart:convert';

import 'package:http/http.dart' as http;

class PostsService {
  static const fetchLimit = 10;

  final baseUrl = "https://jsonplaceholder.typicode.com/posts";

  Future<List<dynamic>> fetchPosts(int page) async {
    try {
      final response = await http
          .get(Uri.parse(baseUrl + "?_limit=$fetchLimit&_page=$page"));
      return jsonDecode(response.body) as List<dynamic>;
    } catch (e) {
       return [];
    }
   
  }
}
