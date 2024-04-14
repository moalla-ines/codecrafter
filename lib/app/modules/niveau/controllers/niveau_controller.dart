import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NiveauController extends GetxController {
  late final String imageUrl;
  final count = 0.obs;
  final GlobalKey<NavigatorState> niveauViewKey = GlobalKey<NavigatorState>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
