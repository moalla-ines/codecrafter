import 'package:codecrafter/app/model/model_user.dart';
import 'package:codecrafter/app/model/registrations.dart';
import 'package:codecrafter/app/modules/home/views/home_view.dart';
import 'package:codecrafter/app/services/userservice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';



class LoginController extends GetxController {

  late TextEditingController usernameController;
  late TextEditingController passwordController;


  @override
  void onInit() {
    super.onInit();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  void onSubmitLoginForm() async {
    if (usernameController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      try {
        // Appel du service pour récupérer les utilisateurs
        List<Users> users = await UsersServices.getAllUsers();
print(users);
        // Comparaison des données de connexion avec les utilisateurs récupérés
        for (Users user in users) {
          if (user.username == usernameController.text && user.password == passwordController.text) {
            // Connexion réussie, naviguer vers la page d'accueil
            Get.to(() => HomeView());
            return;
          }
        }

        // Si aucune correspondance n'est trouvée, afficher un message d'erreur
        Get.snackbar('Erreur', 'Identifiants incorrects.');
      } catch (e) {
        // En cas d'erreur lors de la récupération des utilisateurs, afficher un message d'erreur
        Get.snackbar('Erreur', 'Une erreur s\'est produite lors de la connexion.');
      }
    } else {
      // Si l'un des champs est vide, afficher un message d'erreur
      Get.snackbar('Erreur', 'Veuillez remplir tous les champs.');
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
