import 'dart:convert';
import 'package:codecrafter/app/modules/home/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';


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
        Get.snackbar('Error', 'Please fill in all fields'); // Affiche un message d'erreur
        return;
      }

      final response = await http.post(
        Uri.parse('http://localhost:8080/api/v1/auth/authenticate'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': emailController.text,
          'password': passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final token = responseData['token'] as String?;
        if (token != null) {
          Get.offAll(() => HomeView());
        } else {
          Get.snackbar('Error', 'Invalid token');
        }
      } else {
        Get.snackbar('Connection Error', 'Incorrect email or password');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while logging in');
    }
  }
}
