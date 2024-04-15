import 'dart:convert';

import 'package:codecrafter/app/modules/home/views/home_view.dart';
import 'package:codecrafter/app/modules/home/views/list.dart';
import 'package:codecrafter/app/modules/home/views/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class HomeController extends GetxController {
  var selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    selectedIndex.value = 1;
  }

  void changePassword() {
    String oldPassword = '';
    String newPassword = '';
    Get.defaultDialog(
      title: 'Change Password',
      content: Column(
        children: [
          TextField(
            decoration: InputDecoration(hintText: 'Enter your old password'),
            onChanged: (value) {
              oldPassword = value;
            },
          ),
          TextField(
            decoration: InputDecoration(hintText: 'Enter new password'),
            onChanged: (value) {
              newPassword = value;
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (oldPassword.isNotEmpty && newPassword.isNotEmpty) {
              updateUser(1, oldPassword, newPassword);
            } else {
              Get.snackbar('Error', 'Passwords cannot be empty');
            }
            Get.back();
          },
          child: Text('Save'),
        ),
      ],
    );
  }

  void updateUser(int id, String oldPassword, String newPassword) async {
    final url = Uri.parse('http://localhost:8080/api/v1/user/$id/password');

    try {
      final response = await http.put(
        url,
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json",
          // Les en-têtes Access-Control-Allow-* sont généralement utilisés par le serveur et ne doivent pas être définis par le client.
           "Access-Control-Allow-Origin": "*",
           "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
        },
        body: jsonEncode(<String, String>{
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        }),
      );
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final token = responseData['token'] as String?;
        if (token != null) {
          Get.snackbar('Success', 'Password changed successfully');
        } else {
          throw Exception('Failed to change password');
        }
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
        Get.off(() => SettingsView());
        break;
      case 1:
        Get.off(() => HomeView());
        break;
      case 2:
        Get.off(() => ListViewPage());
        break;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
