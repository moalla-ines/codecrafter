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

  // Fonction pour changer le mot de passe
  void changePassword() {
    Get.defaultDialog(
      title: 'Change Password',
      content: TextField(
        decoration: InputDecoration(hintText: 'Enter new password'),
        onChanged: (value) {
          // Mettre à jour le mot de passe dans la base de données
          updateUser(1, value); // Remplacez 1 par l'ID de l'utilisateur
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back(); // Fermer la boîte de dialogue
          },
          child: Text('Save'),

        ),

      ],
    );
  }

  void updateUser(int id, String password) async {
    final url = Uri.parse('http://localhost:8080/api/v1/user/$id');

    final response = await http.put(url,
        headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"

      },
      body: jsonEncode(<String, dynamic>{
        'id': id,
        'password': password,

      }),
    );
    print(response.statusCode);
    print(json.decode(response.body));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final token = responseData['token'] as String?;
      if (token != null){

      }

        Get.snackbar('Success', 'Password changed successfully');
    } else if (response.statusCode == 403) {
      throw Exception('Unauthorized'); // Utilisateur non autorisé
    } else {
      throw Exception('Failed to change password'); // Échec de la mise à jour du mot de passe
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
