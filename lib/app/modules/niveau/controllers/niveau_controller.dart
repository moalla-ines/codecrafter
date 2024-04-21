import 'package:codecrafter/app/model/model_niveau.dart';
import 'package:codecrafter/app/services/niveauxservice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NiveauController extends GetxController {
  late final String imageUrl;
  final count = 0.obs;
  final GlobalKey<NavigatorState> niveauViewKey = GlobalKey<NavigatorState>();
  final NiveauxService niveauxService = Get.find();
  final niveaux = <Niveau>[].obs;

  @override
  void onInit() {
  super.onInit();
  // Appel initial pour récupérer les niveaux (avec une catégorie par défaut de 1)
  fetchNiveaux(1);
  }
  void fetchNiveaux(int categorie) async {
    try {
      final token = niveauxService.token.value;
      final data = await niveauxService.getNiveauByCategorie(categorie);
      niveaux.assignAll(data);
    } catch (e) {
      print('Failed to load niveaux: $e');
      // Gérer l'erreur comme vous le souhaitez
    }
  }


  @override
  void onReady() {
  super.onReady();
  }

  @override
  void onClose() {
  super.onClose();
  }
  }
