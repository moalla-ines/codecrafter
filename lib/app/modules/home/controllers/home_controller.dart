import 'dart:convert';

import 'package:codecrafter/app/services/quizhistoryService.dart';
import 'package:codecrafter/app/services/userservice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:codecrafter/app/modules/home/views/home_view.dart';
import 'package:codecrafter/app/modules/home/views/list.dart';
import 'package:codecrafter/app/modules/home/views/settings.dart';

class HomeController extends GetxController {
  final HistoriesService historiesService = Get.find();
  var selectedIndex = 0.obs;
  int? id;
  String? role;
  int? score;
  var quizHistory = [].obs;
int? categorie ;
  @override
  void onInit() {
    super.onInit();
    selectedIndex.value = 1;
  }

  void changePassword() {
    String newPassword = '';

    Get.defaultDialog(
      backgroundColor: Colors.grey.shade100,
      title: 'Change Password',
      content: Column(
        children: [
          TextField(
            decoration
                : InputDecoration(hintText: 'Enter new password'),
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
              print(id);
              updateUser(id, newPassword);
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

  void updateUser(int? id, String newPassword) async {
    try {
      final AuthService authService = Get.find<AuthService>();
      final token = authService.token;
      print(token);
      print(id);
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
        body: newPassword,
      );

      print(response.statusCode);
      print(json.decode(response.body));
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
  void fetchQuizHistoriesByUser(int? user) async {
    try {
      print('123 $user');
      final token = historiesService.token.value;
      final data = await historiesService.getQuizHistoryByUser(user!);

      print(data);
      quizHistory.assignAll(data);
      update();
    } catch (e) {
      print('Failed to load quizHistory: $e');
    }
  }

  void getAllQuizHistories() async {
    try {
      final token = historiesService.token.value;
      final data = await historiesService.getAllQuizHistory();

      print(data);
      quizHistory.assignAll(data);
      update();
    } catch (e) {
      print('Failed to load quizHistory: $e');
    }
  }


    void onItemTapped(int index) {
      print(" nanes $id, $role");
      selectedIndex.value = index;
      switch (index) {
        case 0:
          Get.off(() => SettingsView());
          break;
        case 1:
          Get.to(() =>
              HomeView()); // Utilise Get.to pour empiler la vue HomeView
          break;
        case 2:
          Get.off(() => ListViewPage());
          break;
      }
    }
  }
