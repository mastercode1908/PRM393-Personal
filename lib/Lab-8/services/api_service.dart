import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  // Fetch posts from API
  Future<List<Post>> fetchPosts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/posts?_limit=10'));

      if (response.statusCode == 200) {
        // Decode JSON response
        final List<dynamic> jsonData = json.decode(response.body);
        
        // Convert JSON to List<Post>
        return jsonData.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load posts (Status: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Failed to load posts: $e');
    }
  }

  // Optional: Create a new post
  Future<Post> createPost(Post post) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/posts'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(post.toJson()),
      );

      if (response.statusCode == 201) {
        return Post.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create post (Status: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Failed to create post: $e');
    }
  }
}
