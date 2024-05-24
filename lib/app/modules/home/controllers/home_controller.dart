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
  var selectedItems = <bool>[].obs;
  int? categorie;

  @override
  void onInit() {
    super.onInit();
    selectedIndex.value = 1;
    selectedItems.value = List.filled(quizHistory.length, false);  // Initialize with false
  }

  void changePassword() {
    String newPassword = '';

    Get.defaultDialog(
      backgroundColor: Colors.grey.shade100,
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

      final url = Uri.parse('http://172.20.10.2:8080/api/v1/user/$id/password');

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
      final data = await historiesService.getQuizHistoryByUser(user!);
      quizHistory.assignAll(data);
      selectedItems.value = List.filled(quizHistory.length, false);  // Update selectedItems length
      update();
    } catch (e) {
      print('Failed to load quizHistory: $e');
    }
  }

  void getAllQuizHistories() async {
    try {
      final data = await historiesService.getAllQuizHistory();
      quizHistory.assignAll(data);
      selectedItems.value = List.filled(quizHistory.length, false);  // Update selectedItems length
      update();
    } catch (e) {
      print('Failed to load quizHistory: $e');
    }
  }

  void onDeleteHistoryQuiz(int? idquizhistory) async {
    try {
      await historiesService.deleteHistoryQuizzes(idquizhistory!);
      update();

      Get.snackbar('Succès', 'Quiz-history supprimé avec succès !');
    } catch (e) {
      Get.snackbar('Erreur', 'Échec de la suppression du quiz-history : $e');
    }
  }

  void toggleQuizSelection(int idquizhistory) {
    selectedItems[idquizhistory] = !selectedItems[idquizhistory];
    update();
  }

  void onItemTapped(int index) {
    print("nanes $id, $role");
    selectedIndex.value = index;
    switch (index) {
      case 0:
        Get.off(() => SettingsView(role: role, id: id));
        break;
      case 1:
        Get.off(() => HomeView(role: role, id: id)); // Utilise Get.to pour empiler la vue HomeView
        break;
      case 2:
        Get.off(() => ListViewPage(role: role, id: id));
        break;
    }
  }
}
