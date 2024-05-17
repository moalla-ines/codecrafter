import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:codecrafter/app/model/model_niveau.dart';
import 'package:codecrafter/app/modules/quiz/views/quiz_view.dart';
import 'package:codecrafter/app/services/niveauxservice.dart';

import '../controllers/niveau_controller.dart';

class NiveauView extends GetView<NiveauController> {
  final String? imageUrl;
  final int? index;
  final String? role;
  final int? id;

  NiveauView({Key? key, this.imageUrl, this.index, this.role, this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.role = role;
    controller.id = id;
    return Scaffold(
      backgroundColor: const Color(0xFFFF1F1F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2C4E80),
        title: const Text(
          'Niveau',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            controller.niveaux = [].obs;
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() {
                if (controller.niveaux.isEmpty) {
                  // Fetch data if niveaux is empty
                  controller.fetchNiveaux(index);

                  return const Center(child: CircularProgressIndicator(color: Color(0xFFF2C4E80)));
                } else if (controller.niveaux.isEmpty) {
                  // If niveaux is still empty, return a message or placeholder widget
                  return const Center(child: Text('No data available'));
                } else {
                  // Build the UI using niveaux data
                  return Column(
                    children: [
                      for (var niveau in controller.niveaux)
                        _buildNiveauTile(
                          context,
                          niveau.idNiveau.toString(),
                          utf8.decode(niveau.name!.codeUnits),
                          niveau.categorie!.titreCategorie!,
                          Colors.grey.shade50,
                          imageUrl,
                          niveau,
                        ),
                    ],
                  );
                }
              }),

            ],
          ),
        ),
      ),

    );
  }

  Widget _buildNiveauTile(BuildContext context, String tag, String title,
      String subtitle, Color tileColor, String? imageUrl, Niveau niveau) {
    return Column(
      children: [
        SizedBox(height: 20.0),
        Hero(
          tag: tag,
          child: Material(
            child: Container(
              width: double.infinity, // Set width to match_parent
              child: ListTile(
                leading: imageUrl != null
                    ? Image.asset(imageUrl)
                    : const Icon(Icons.image),

                title: Text(title),
                subtitle: Text(subtitle),
                tileColor: tileColor,
                onTap: () {
                  Get.to(() =>
                      QuizView(
                        imageUrl: imageUrl,
                        niveau: niveau.idNiveau,
                        categorie: niveau.categorie!.idcategorie,
                        role: controller.role,
                        id: id,
                      ));
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
