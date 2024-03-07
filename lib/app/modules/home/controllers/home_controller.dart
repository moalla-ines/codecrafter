import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  var selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  // Navigation
  void onItemTapped(int index) {
    selectedIndex.value = index;
    //switch (index) {
    //  case 0:
      //  Get.off(() => SettingsView());
        //break;
     // case 1:
       // Get.off(() => AcceuilView());
        //break;
      //case 2:
        //Get.off(() => ListViewPage());
        //break;

  }

  @override
  void onClose() {
    super.onClose();
  }

}
