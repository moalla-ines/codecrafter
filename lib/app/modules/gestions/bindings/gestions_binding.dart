import 'package:get/get.dart';

import '../controllers/gestions_controller.dart';

class GestionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GestionsController>(
      () => GestionsController(),
    );
  }
}
