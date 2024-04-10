import 'package:get/get.dart';

import '../controllers/niveau_controller.dart';

class NiveauBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NiveauController>(
      () => NiveauController(),
    );
  }
}
