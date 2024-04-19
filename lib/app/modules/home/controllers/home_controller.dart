import 'dart:convert';

import 'package:codecrafter/app/services/userservice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:codecrafter/app/modules/home/views/home_view.dart';
import 'package:codecrafter/app/modules/home/views/list.dart';
import 'package:codecrafter/app/modules/home/views/settings.dart';


class HomeController extends GetxController {
  final AuthService authService = Get.find<AuthService>();
  var selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    selectedIndex.value = 1;
  }
  void changePassword() {
    String newPassword = '';
    Get.defaultDialog(
      title: 'Change Password',
      content: Column(
        children: [
          TextField(
            decoration: InputDecoration(hintText: 'Enter new password'),
            obscureText: true,
            onChanged: (value) {
              newPassword = value;
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (newPassword.isNotEmpty) {
              String? token = authService.token;
              int userId = authService.getUserIdFromToken(token!) ?? 0; // 0 est une valeur par défaut, vous pouvez utiliser une autre valeur si nécessaire

              if (userId != null) {
                updateUser(userId, newPassword);
              } else {
                Get.snackbar('Error', 'User ID not found in token');
              }
            } else {
              Get.snackbar('Error', 'Password must not be empty');
            }

            Get.back();
          },
          child: Text('Save'),
        ),
      ],
    );
  }



  Future<String> updateUser(int id, String password) async {
    try {
      final token = getToken() ?? ''; // Utilisation d'une valeur par défaut si le token est null

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


  void onItemTapped(int index) {
    selectedIndex.value = index;
    switch (index) {
      case 0:
        Get.to(() => SettingsView());
        break;
      case 1:
        Get.to(() => HomeView());
        break;
      case 2:
        Get.to(() => ListViewPage());
        break;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
