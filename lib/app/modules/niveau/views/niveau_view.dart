import 'package:codecrafter/app/modules/quiz/views/quiz_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/niveau_controller.dart';

class NiveauView extends GetView<NiveauController> {
  const NiveauView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF732DA2),


      appBar: AppBar(
        backgroundColor: const Color(0xFFF732DA2) ,
        title: Text('Niveau', style: TextStyle(color: Colors.grey.shade200, fontWeight: FontWeight.bold),   ),
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
                  'pour les debutants',
                  Colors.grey.shade200,
                  SizedBox(height: 2),
                  Container(
                    padding: EdgeInsets.all(3),
                  ),
                ),
                buildHeroTile(
                  context,
                  ' niveau 02',
                  'moyen',
                  'pour les peux experiencés',
                  Colors.grey.shade200,
                  SizedBox(height: 2),
                  Container(
                    padding: EdgeInsets.all(3),
                  ),
                ),
                buildHeroTile(
                  context,
                  'niveau 03',
                  'difficile  ',
                  'pour les profecionnels',
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

  Widget buildHeroTile(BuildContext context, String tag, String title,
      String subtitle, Color tileColor, Widget? sizedBox, Widget? container) {
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
                Get.to(QuizView());
              },
            ),
          ),
        ),
      ],
    );
  }
}