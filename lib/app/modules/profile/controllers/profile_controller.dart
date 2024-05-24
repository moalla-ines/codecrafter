import 'package:codecrafter/app/model/historiques.dart';
import 'package:codecrafter/app/model/model_user.dart';
import 'package:codecrafter/app/services/userservice.dart';

import 'package:get/get.dart';

class ProfileController extends GetxController {
  final AuthService userService = Get.find();
  String? role;
  int? id;
  var users = [].obs;
  var selectedUser = <int>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  void updateSelectedRole(String selectedRole) {
    print("role selectionné $selectedRole");
    print("id selectionné ${selectedUser.single}");

    if (selectedRole == "admin" || selectedRole == "user") {
      // Mettre à jour le rôle sélectionné pour l'utilisateur avec l'ID userId
      userService.updateUserRole(selectedUser.single, selectedRole);
      // Actualiser l'interface utilisateur
      update();
    } else {
      // Gérer une erreur ou afficher un message d'erreur
      print("Le rôle doit être soit 'admin' soit 'user'");
    }
  }

  void fetchAllUsers() async {
    try {
      final data = await userService.getAllUsers();
      users.assignAll(data);
      print(data);
      update();
    } catch (e) {
      print('Failed to load users: $e');
    }
  }
  // Dans votre controller

  void onDeleteUsers(int id) async {
    try {
      await userService.deleteUsers(id);
      update();
      Get.snackbar('Succès', 'user supprimé avec succès !');
    } catch (e) {
      Get.snackbar('Erreur', 'Échec de la suppression du user : $e');
    }
  }

  void toggleUserSelection(int id) {
    if (selectedUser.contains(id)) {
      selectedUser.remove(id);
    } else {
      selectedUser.add(id);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
