import 'package:codecrafter/app/model/registrations.dart';
import 'package:codecrafter/app/modules/home/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InscriptionController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final RegistrationData inscriptionData = RegistrationData();
  final username = RxString('');
  final password = RxString('');
  final confirmPassword = RxString('');
  final email = RxString('');

  void submitForm() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      Get.to(() => HomeView());
      Get.snackbar('Success', 'Form submitted successfully');
    }
  }

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
}
