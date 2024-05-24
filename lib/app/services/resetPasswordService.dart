import 'dart:convert';
import 'package:codecrafter/app/modules/login/views/login_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

class PasswordResetService {
  Future<void> resetPassword(String email) async {
    final String url = 'http://172.20.10.2:8080/api/v1/reset-password';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'email': email,
        },
      );

      if (response.statusCode == 200) {
        // Réinitialisation du mot de passe réussie

        Get.snackbar(
            'Succès', 'Un code de réinitialisation a été envoyé à votre email');
      } else {
        Get.snackbar('Erreur', 'Adresse e-mail non trouvée.');
        // Gestion des erreurs
        print('Failed to reset password: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to reset password. $e');
      // Erreur lors de la communication avec le serveur
      print('Failed to reset password: $e');
    }
  }

  Future<void> checkTokenValidity(String token) async {
    try {
      final response = await http.get(
        Uri.parse('http://172.20.10.2:8080/api/v1/reset-password?token=$token'),
      );

      if (response.statusCode == 200) {
        // Le jeton est valide, rediriger vers la page de changement de mot de passe
        Get.offNamed('/change-password', arguments: token);
      } else {
        // Le jeton est invalide ou expiré, afficher un message d'erreur
        Get.snackbar('Erreur', 'Token invalide ou expiré');
      }
    } catch (e) {
      // Une erreur s'est produite lors de la communication avec le serveur, afficher un message d'erreur
      Get.snackbar('Erreur', 'Une erreur s\'est produite');
    }
  }

  Future<void> changePassword(String token, String newPassword) async {
    if (token.isEmpty) {
      // Handle the case where the token is missing
      Get.snackbar('Erreur', 'Le token est manquant. Veuillez réessayer.');
      return;
    }
    print(token);
    print(newPassword);
    try {
      final response = await http.post(
        Uri.parse(
            'http://172.20.10.2:8080/api/v1/reset-password/change-Password?token=$token&newPassword=$newPassword'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        Get.snackbar('Succès', 'Mot de passe réinitialisé avec succès.');
        Get.to(LoginView());
      } else {
        Get.snackbar('Erreur', 'Échec de la réinitialisation du mot de passe.');
      }
    } catch (e) {
      print(e);
      Get.snackbar('Erreur', 'Une erreur est survenue. Veuillez réessayer.');
    }
  }
}
