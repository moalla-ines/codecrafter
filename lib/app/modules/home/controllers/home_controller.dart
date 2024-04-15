import 'dart:convert';

import 'package:codecrafter/app/services/userservice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:codecrafter/app/modules/home/views/home_view.dart';
import 'package:codecrafter/app/modules/home/views/list.dart';
import 'package:codecrafter/app/modules/home/views/settings.dart';


class HomeController extends GetxController {
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
              updateUser(1, newPassword);
            } else {
              Get.snackbar('Error', 'Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, and one digit');
            }
            Get.back();
          },
          child: Text('Save'),
        ),
      ],
    );
  }

  void updateUser(int id, String newPassword) async {
    try {
      final AuthService authService = Get.find<AuthService>();
      final token = await authService.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      final url = Uri.parse('http://localhost:8080/api/v1/user/$id/password');

      final response = await http.put(
        url,
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(<String, String>{
          'newPassword': newPassword,
        }),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Password changed successfully');
      } else if (response.statusCode == 403) {
        throw Exception('Unauthorized');
      } else {
        throw Exception('Failed to change password');
      }
    } catch (e) {
      print('Failed to update password: $e');
      Get.snackbar('Error', 'Failed to change password');
    }
  }

  // Navigation
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
