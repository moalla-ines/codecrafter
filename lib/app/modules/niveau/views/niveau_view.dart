import 'package:codecrafter/app/modules/quiz/controllers/quiz_controller.dart';
import 'package:codecrafter/app/modules/quiz/views/quiz_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/niveau_controller.dart';

class NiveauView extends GetView<NiveauController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF732DA2),
      appBar: AppBar(
        backgroundColor: Color(0xFFF732DA2),
        title: Text(
          'Niveau',
          style: TextStyle(color: Colors.grey.shade200, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 10),
                buildHeroTile(
                  context,
                  'niveau 01 ',
                  'Facile',
                  'pour les débutants',
                  Colors.grey.shade200,
                  SizedBox(height: 2),
                  Container(
                    padding: EdgeInsets.all(3),
                  ),
                ),
                buildHeroTile(
                  context,
                  'niveau 02',
                  'Moyen',
                  'pour les peu expérimentés',
                  Colors.grey.shade200,
                  SizedBox(height: 2),
                  Container(
                    padding: EdgeInsets.all(3),
                  ),
                ),
                buildHeroTile(
                  context,
                  'niveau 03',
                  'Difficile',
                  'pour les professionnels',
                  Colors.grey.shade200,
                  SizedBox(height: 2),
                  Container(
                    padding: EdgeInsets.all(3),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget buildHeroTile(BuildContext context, String tag, String title, String subtitle, Color tileColor, Widget? sizedBox, Widget? container) {
    final GlobalKey<NavigatorState> niveauViewKey = GlobalKey<NavigatorState>(); // Déplacez cette ligne ici

    return Column(
      children: [
        if (sizedBox != null) sizedBox,
        if (container != null) container,
        Hero(
          tag: tag,
          child: Material(
            child: ListTile(
              title: Text(title),
              subtitle: Text(subtitle),
              tileColor: tileColor,
              onTap: () {
                Get.to(() => QuizView(key: niveauViewKey)); // Utilisez la clé ici
              },
            ),
          ),
        ),
      ],
    );
  }
}

