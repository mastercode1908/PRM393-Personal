import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  // --- Lab 10.2: Real REST API Login (DummyJSON) ---
  Future<Map<String, dynamic>> loginWithApi(String username, String password) async {
    final url = Uri.parse('https://dummyjson.com/auth/login');
    
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
          // Expires in 30 mins
          'expiresInMins': 30,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'token': data['token'],
          'username': data['username'],
        };
      } else {
        final errorData = jsonDecode(response.body);
        return {
          'success': false,
          'message': errorData['message'] ?? 'Login failed',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error: $e',
      };
    }
  }

  // --- Lab 10.4: Mock Firebase Google Sign-In ---
  // To avoid complex Firebase configuration, we simulate a successful Google Sign-In here.
  Future<Map<String, dynamic>> mockGoogleSignIn() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Simulate successful Google authentication returning a token and profile
    return {
      'success': true,
      'token': 'mock-google-token-12345',
      'username': 'Google User',
    };
  }
}
