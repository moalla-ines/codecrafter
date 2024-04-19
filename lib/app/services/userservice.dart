import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthService extends GetxService {
  String? _token;

  String? get token => _token;

  void setToken(String? token) {
    _token = token;
  }

// Utilisez le token ici
  void clearToken() {
    _token = null;
  }

  int? getUserIdFromToken(String token) {
    // Décoder le token JWT pour obtenir les informations nécessaires
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid token');
    }

    final payload = parts[1];
    final String normalized = base64Url.normalize(payload);
    final String decoded = utf8.decode(base64Url.decode(normalized));

    // Convertir le JSON en une carte clé-valeur
    final Map<String, dynamic> json = jsonDecode(decoded);

    // Extraire l'ID de l'utilisateur du JSON
    return json['sub'];
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

  Future<String> register(String username, String email,
      String password) async {
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
      final token = getToken();
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
        final newToken = responseData['token'] as String;
        setToken(newToken);
        return newToken;
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


  Future<int?> getUserIdFromEmail(String email) async {
    final url = Uri.parse('http://localhost:8080/api/v1/user');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      final List<dynamic> users = jsonDecode(response.body);
      final user = users.firstWhere((user) => user['email'] == email,
          orElse: () => null);
      if (user != null) {
        return user['id'] as int?;
      } else {
        throw Exception('User not found');
      }
    } else {
      throw Exception('Failed to fetch users');
    }
  }
}
