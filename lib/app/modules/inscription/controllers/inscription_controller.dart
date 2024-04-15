import 'dart:convert';
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

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer une adresse e-mail';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Veuillez entrer une adresse e-mail valide';
    }
    return null;
  }

  void onRegisterForm() async {
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

      print(response.statusCode);
      print(json.decode(response.body));

      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        final token = responseData['token'] as String?;
        if (token != null) {
          Get.to(() => HomeView());
          Get.snackbar('Success', 'Form submitted successfully');
        } else {
          Get.snackbar('Error', 'Invalid token');
        }
      } else {
        Get.snackbar('Connection Error', 'Incorrect email or password');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while logging in');
      print(e);
    }
  }
}
