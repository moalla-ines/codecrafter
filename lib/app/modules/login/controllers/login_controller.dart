import 'package:codecrafter/app/model/model_user.dart';
import 'package:codecrafter/app/model/registrations.dart';
import 'package:codecrafter/app/modules/home/controllers/home_controller.dart';
import 'package:codecrafter/app/modules/home/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class LoginController extends GetxController {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  String? imagePath;


  @override
  void onInit() {
    super.onInit();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }



  void onSubmitRegistrationForm(String username, String password,
      String email) {
    if (username.isNotEmpty && password.isNotEmpty && email.isNotEmpty) {
      // Créer une instance de User avec les données du formulaire
      User user = User(username: username, password: password);

      // Créer une instance de RegistrationData avec les données du formulaire
      RegistrationData registrationData = RegistrationData(
        username: username,
        password: password,
        email: email,
      );


      @override
      void onClose() {
        usernameController.dispose();
        passwordController.dispose();
        super.onClose();
      }
    }
  }
}