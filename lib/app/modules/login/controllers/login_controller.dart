import 'dart:convert';

import 'package:codecrafter/app/services/userservice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:codecrafter/app/modules/home/views/home_view.dart';


class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void onSubmitLoginForm() async {
    try {
      if (emailController.text.isEmpty || passwordController.text.isEmpty) {
        Get.snackbar('Error', 'Please fill in all fields');
        return;
      }

      final response = await http.post(
        Uri.parse('http://localhost:8080/api/v1/auth/authenticate'),
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
        },
        body: jsonEncode(<String, String>{
          'email': emailController.text,
          'password': passwordController.text,
        }),
      );

      print(response.statusCode);
      print(json.decode(response.body));

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final token = responseData['token'] as String?;
        if (token != null) {
          final AuthService authService = Get.find<AuthService>();
          // Obtenez l'ID de l'utilisateur à partir de son email
          int? userId = authService.getUserIdFromEmail(emailController.text);
          if (userId != null) {
            // Utilisez l'ID de l'utilisateur
            print('User ID: $userId');
            Get.offAll(() => HomeView());
          } else {
            Get.snackbar('Error', 'User not found');
          }
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