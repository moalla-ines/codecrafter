import 'dart:convert';
import 'package:codecrafter/app/model/model_user.dart';
import 'package:http/http.dart' as http;


class UsersServices {
  static Future<List<Users>> getAllUsers() async {
    final url = Uri.parse('http://localhost:8080/api/v1/user');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> usersList = jsonData['users'];
      List<Users> users = [];

      for (var item in usersList) {
        users.add(Users.fromJson(item));
      }

      return users;
    } else {
      throw Exception('Failed to load users');
    }
  }
}
