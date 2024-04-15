import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthService extends GetxService {
  String? _token;

  void setToken(String token) {
    _token = token;
  }

  Future<String?> getToken() async {
    // Simuler une récupération de token (à remplacer par votre propre logique)
    await Future.delayed(Duration(seconds: 1));
    return _token;
  }

  Future<String> authenticate(String email, String password) async {
    final url = Uri.parse('http://localhost:8080/api/v1/auth/authenticate');

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final token = responseData['token'];
      setToken(token);
      return token;
    } else if (response.statusCode == 403) {
      throw Exception('Unauthorized');
    } else {
      throw Exception('Failed to authenticate');
    }
  }

  Future<String> register(String username, String email, String password) async {
    final url = Uri.parse('http://localhost:8080/api/v1/auth/register');

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
        'email': email,
      }),
    );

    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      final token = responseData['token'];
      setToken(token);
      return token;
    } else if (response.statusCode == 403) {
      throw Exception('Unauthorized');
    } else {
      throw Exception('Failed to register');
    }
  }

  Future<String> updateUser(int id, String password) async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      final url = Uri.parse('http://localhost:8080/api/v1/user/$id/password');

      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, dynamic>{
          'id': id,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final token = responseData['token'];
        setToken(token);
        return token;
      } else if (response.statusCode == 403) {
        throw Exception('Unauthorized');
      } else {
        throw Exception('Failed to change password');
      }
    } catch (e) {
      print('Failed to update password: $e');
      throw Exception('Failed to update password');
    }
  }
}
