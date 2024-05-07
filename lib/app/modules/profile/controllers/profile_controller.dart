import 'package:codecrafter/app/model/historiques.dart';
import 'package:codecrafter/app/model/model_user.dart';
import 'package:codecrafter/app/services/userservice.dart';

import 'package:get/get.dart';

class ProfileController extends GetxController {
  final AuthService userService = Get.find();
  String? role;
  int? id ;
var users = [].obs;
  @override
  void onInit() {
    super.onInit();
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

  @override
  void onClose() {
    super.onClose();
  }
}
