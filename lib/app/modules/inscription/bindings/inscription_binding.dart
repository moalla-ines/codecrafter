import 'package:get/get.dart';

import '../controllers/inscription_controller.dart';

class InscriptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InscriptionController>(
      () => InscriptionController(),
    );
  }
}
