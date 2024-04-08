import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:codecrafter/app/modules/home/views/home_view.dart';

class LoginController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    assert(emailController != null);
    passwordController = TextEditingController();
    assert(passwordController != null);
  }

  void onSubmitLoginForm() async {
    assert(emailController != null);
    assert(passwordController != null);

    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      try {
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


        assert(response != null);

        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);
          final token = responseData['token'] as String?;
          assert(token != null);
            // Stocker le token dans un endroit sécurisé comme le stockage local
            // Naviguer vers la page d'accueil après l'authentification réussie
            Get.to(() => HomeView());
        } else {
          Get.snackbar('Erreur de connexion', 'Email ou mot de passe incorrect');
        }
      } catch (e) {
        print('ines');
        Get.snackbar('Erreur', 'Une erreur s\'est produite lors de la connexion');
      }
    } else {
      Get.snackbar('Erreur', 'Veuillez remplir tous les champs');
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}

