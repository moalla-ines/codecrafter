import 'dart:convert';
import 'package:codecrafter/app/model/historiques.dart';
import 'package:codecrafter/app/model/model_user.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthService extends GetxService {
  String? _token;

  String? get token => _token;

  void setToken(String token) {
    _token = token;
  }

  void clearToken() {
    _token = null;
  }

  Future<String?> getToken() async {
    // Simuler une récupération de token (à remplacer par votre propre logique)
    await Future.delayed(Duration(seconds: 1));
    return _token;
  }

  Future<String> authenticate(String email, String password) async {
    final url = Uri.parse('http://172.20.10.2:8080/api/v1/auth/authenticate');

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

  Future<String> register(
      String username, String email, String password) async {
    final url = Uri.parse('http://172.20.10.2:8080/api/v1/auth/register');
    print(username);
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

    if (response.statusCode == 200) {
      print(
          'Registration successful. Please check your email for verification.');

      return 'Inscription réussie. Veuillez vérifier votre e-mail pour la confirmation.';
    } else if (response.statusCode == 403) {
      throw Exception('Unauthorized');
    } else {
      throw Exception('Failed to register');
    }
  }

  Future<void> verifyEmail(String token) async {
    final url =
    Uri.parse('http://172.20.10.2:8080/api/v1/auth/verify?token=$token');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print('Email verified successfully.');
    } else {
      throw Exception('Failed to verify email');
    }
  }

  Future<String> updateUser(int id, String password) async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      final url = Uri.parse('http://172.20.10.2:8080/api/v1/user/$id/password');

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

  Future<void> updateUserRole(int userId, String newRole) async {
    try {
      final response = await http.put(
        Uri.parse('http://172.20.10.2:8080/api/v1/user/$userId/role'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: newRole,
      );

      if (response.statusCode == 200) {
        // Le rôle de l'utilisateur a été mis à jour avec succès
      } else {
        // Gérer l'échec de la mise à jour du rôle
        throw Exception('Échec de la mise à jour du rôle');
      }
    } catch (e) {
      // Gérer les erreurs de connexion ou de traitement
      print('Erreur lors de la mise à jour du rôle : $e');
      throw Exception('Erreur lors de la mise à jour du rôle');
    }
  }

  Future<List<User>> getAllUsers() async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      final url = Uri.parse('http://172.20.10.2:8080/api/v1/user');
      final response = await http.get(
        url,
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as List<dynamic>;
        return jsonData.map((json) => User.fromJson(json)).toList();
      } else {
        print('Failed to load users. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load users');
      }
    } catch (e) {
      print('Exception occurred: $e');
      throw Exception('Failed to load users');
    }
  }

  Future<void> deleteUsers(int id) async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      final url = Uri.parse('http://172.20.10.2:8080/api/v1/user/$id');

      final response = await http.delete(
        url,
        headers: <String, String>{
          "Accept": "application/json",
          'Content-Type': 'application/json; charset=utf-8',
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 204) {
        print('User deleted successfully');
        // Handle success as needed
      } else if (response.statusCode == 403) {
        throw Exception('Unauthorized');
      } else {
        print('Failed to delete user. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Exception occurred: $e');
    }
  }

  Future<void> updateUsers(int id, int idrole, String name) async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      final url = Uri.parse('http://172.20.10.2:8080/api/v1/user/$id');

      final response = await http.put(
        url,
        headers: <String, String>{
          "Accept": "application/json",
          'Content-Type': 'application/json; charset=utf-8',
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(<String, dynamic>{
          "roles": [
            {"name": name}
          ]
        }),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'User role updated successfully!');
      } else if (response.statusCode == 403) {
        throw Exception('Unauthorized');
      } else {
        print(
            'Failed to update user role. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Exception occurred: $e');
    }
  }
}
