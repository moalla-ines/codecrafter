import 'package:codecrafter/app/modules/quiz/views/quiz_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/niveau_controller.dart';
class NiveauView extends GetView<NiveauController> {
  final String? imageUrl;

  NiveauView({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF732DA2),
      appBar: AppBar(
        backgroundColor: Color(0xFFF732DA2),
        title: Text(
          'Niveau',
          style: TextStyle(
              color: Colors.grey.shade200, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              if (controller.niveaux.isEmpty) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Column(
                  children: [
                    for (var niveau in controller.niveaux)
                      _buildNiveauTile(
                        context,
                        niveau.idNiveau.toString(),
                        niveau.name!,
                        niveau.categorie!.titreCategorie!,
                        Colors.grey.shade200,
                        imageUrl, // Passer l'URL de l'image sélectionnée
                      ),
                  ],
                );
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildNiveauTile(BuildContext context, String tag, String title,
      String subtitle, Color tileColor, [String? imageUrl]) {
    return Column(
      children: [
        SizedBox(height: 20.0),
        Hero(
          tag: tag,
          child: Material(
            child: ListTile(
              title: Text(title),
              subtitle: Text(subtitle),
              tileColor: tileColor,
              onTap: () {
                Get.to(() => QuizView(imageUrl: imageUrl)); // Utilisez QuizView avec l'URL de l'image
              },
            ),
          ),
        ),
      ],
    );
  }
}

