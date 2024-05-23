import 'dart:convert';
import 'package:codecrafter/app/modules/admin_gestions/views/admin_gestions_view.dart';
import 'package:codecrafter/app/modules/historique/views/historique_view.dart';
import 'package:codecrafter/app/modules/home/views/home_view.dart';
import '../../../services/resetPasswordService.dart';
import 'package:codecrafter/app/services/userservice.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  final PasswordResetService passwordResetService = PasswordResetService();
  final password = RxString('');
  final confirmPassword = RxString('');
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;
  var codeController = TextEditingController();
  get formKey => null;
  var isLoading = false.obs;
  var token = ''.obs;

  @override
  void onInit() {
    super.onInit();

    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer une adresse e-mail';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Veuillez entrer une adresse e-mail valide';
    }
    return null;
  }

  void resetPassword() async {
    final String email = emailController.text.trim();
    if (email.isNotEmpty) {
      try {
        isLoading.value = true;
        await passwordResetService.resetPassword(email);
        await Future.delayed(Duration(seconds: 2));
        isLoading.value = false;
      } catch (e) {
        // Gérer les erreurs
        print('Failed to reset password: $e');
      }
    } else {
      // L'e-mail est vide, afficher un message d'erreur ou effectuer une autre action appropriée
      print('Email is empty');
    }
  }

  Future<void> changePassword() async {
    print(token.value);
    try {
      if (token.value.isEmpty) {
        Get.snackbar('Erreur', 'Le token est manquant. Veuillez réessayer.');
        return;
      }
      await passwordResetService.changePassword(token.value, password.value);
    } catch (e) {
      Get.snackbar('Erreur', 'Échec de la réinitialisation du mot de passe.');
    }
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer un mot de passe';
    } else if (value.length < 8) {
      return 'Le mot de passe doit contenir au moins 8 caractères';
    }
    return null;
  }

  void verifyCodeAndNavigate(String code) async {
    try {
      await passwordResetService.checkTokenValidity(code);
    } catch (e) {
      Get.snackbar('Erreur', 'Code invalide ou expiré');
    }
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

  void logout() {
    emailController.text = '';
    passwordController.text = '';
    // Autres actions de déconnexion
  }
}
