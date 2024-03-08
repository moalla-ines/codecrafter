import 'package:codecrafter/app/modules/home/views/home_view.dart';
import 'package:codecrafter/app/modules/home/views/list.dart';
import 'package:codecrafter/app/modules/home/views/settings.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  var selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    selectedIndex.value = 1;
  }

  @override
  // Navigation
  void onItemTapped(int index) {
    selectedIndex.value = index;
    switch (index) {
      case 0:
        Get.off(() => SettingsView());
        break;
      case 1:
        Get.off(() => HomeView());
        break;
      case 2:
        Get.off(() => ListViewPage());
        break;

  }

  @override
  void onClose() {
    super.onClose();
  }

}}
