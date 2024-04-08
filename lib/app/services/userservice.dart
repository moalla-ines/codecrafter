import 'dart:convert';
import 'package:codecrafter/app/model/model_user.dart';
import 'package:http/http.dart' as http;


class UsersServices {
   Future<List<UserEntity>> getAllUsers() async {
    final url = Uri.parse('http://localhost:8080/api/v1/auth');
    final response = await http.post(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> usersList = jsonData['users'];
      List<UserEntity> users = [];

      for (var item in usersList) {
        users.add(UserEntity.fromJson(item));
      }

      return users;
    } else {
      throw Exception('Failed to load users');
    }
  }
}
