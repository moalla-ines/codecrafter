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
            if (imageUrl != null) ...[

              SizedBox(height: 20.0),
              Center(
                child: Image.asset(
                  imageUrl!,
                  width: 200.0,
                  height: 200.0,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20.0),
            ],
            _buildHeroTile(
              context,
              'niveau 01',
              'Facile',
              'pour les débutants',
              Colors.grey.shade200,
              SizedBox(height: 2),
              Container(
                padding: EdgeInsets.all(3),
              ),
            ),
            _buildHeroTile(
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
            _buildHeroTile(
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
    );
  }

  Widget _buildHeroTile(BuildContext context, String tag, String title,
      String subtitle, Color tileColor, Widget? sizedBox, Widget? container) {
    final GlobalKey<NavigatorState> niveauViewKey = GlobalKey<NavigatorState>();

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
                Get.to(() => QuizView(imageUrl: imageUrl));
              },
            ),
          ),
        ),
      ],
    );
  }
}