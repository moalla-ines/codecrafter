import 'package:get/get.dart';

import '../controllers/admin_gestions_controller.dart';

class AdminGestionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminGestionsController>(
      () => AdminGestionsController(),
    );
  }
}
