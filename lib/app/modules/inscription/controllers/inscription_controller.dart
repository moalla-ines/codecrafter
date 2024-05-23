import 'dart:convert';
import 'package:codecrafter/app/modules/historique/views/historique_view.dart';
import 'package:codecrafter/app/modules/home/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class InscriptionController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final username = RxString('');
  final password = RxString('');
  final confirmPassword = RxString('');
  final email = RxString('');
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;
  var isLoading = false.obs;

  int? id;
  String? role;
  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer un nom d\'utilisateur';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer un mot de passe';
    } else if (value.length < 8) {
      return 'Le mot de passe doit contenir au moins 8 caractères';
    }
    return null;
  }

  String? validateVerPassword(String? confirmPassword, String? password) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Veuillez entrer un mot de passe';
    } else if (confirmPassword.length < 8) {
      return 'Le mot de passe doit contenir au moins 8 caractères';
    } else if (confirmPassword != password) {
      return 'Les mots de passe ne correspondent pas';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer une adresse e-mail';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Veuillez entrer une adresse e-mail valide';
    }
    return null;
  }

  void onRegisterForm() async {
    isLoading.value = true;
    try {
      final response = await http.post(
        Uri.parse('http://localhost:8080/api/v1/auth/register'),
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
        },
        body: jsonEncode(<String, String>{
          'username': username.value,
          'email': email.value,
          'password': password.value,
        }),
      );
      if (response.statusCode == 200) {
        isLoading.value = false;
        Get.snackbar('Success',
            'Inscription réussie. Veuillez vérifier votre e-mail pour la confirmation.');
      } else if (response.statusCode == 500) {
        isLoading.value = false;
        Get.snackbar('Error', 'Username or Email already exists');
      } else {
        Get.snackbar('Connection Error', 'An error occurred while registering');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while registering');
      print(e);
    }
  }
}
