import 'package:codecrafter/app/modules/gestions/views/gestion_categorie.dart';
import 'package:codecrafter/app/modules/gestions/views/gestions_view.dart';
import 'package:codecrafter/app/modules/historique/views/historique_view.dart';
import 'package:codecrafter/app/modules/home/views/home_view.dart';
import 'package:codecrafter/app/modules/profile/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/admin_gestions_controller.dart';

class AdminGestionsView extends GetView<AdminGestionsController> {
  final int? id;
  final String? role;
  final int? score;
  AdminGestionsView({this.id, this.role, this.score});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFF1F1F2),
      appBar: AppBar(
        title: Text(
          'Gestions',
          style: TextStyle(color: Color(0xFFF2C4E80), fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFFF1F1F2),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),

        child: ListView(
          padding: EdgeInsets.all(16.0),

          children: [
          SizedBox(height: 70,),
            ListTile(
              tileColor: Color(0xFFF2C4E80),
              title: Text('Gestion de Catégorie',style: TextStyle(color: Color(0xFFFF1F1F2)),),
              onTap: () {
                Get.to(() => GestionCategorieView(role: role, id: id));
              },
            ),
            SizedBox(height: 20),
            ListTile(
              tileColor: Color(0xFFF2C4E80),
              title: Text('Gestion de L\'historique',style: TextStyle(color: Color(0xFFFF1F1F2)),),
              onTap: () {
                Get.to(() => HistoriqueView(id: id, role: role));
              },
            ),
            SizedBox(height: 20),
            ListTile(
              tileColor: Color(0xFFF2C4E80),
              title: Text('Gestion des Utilisateurs',style: TextStyle(color: Color(0xFFFF1F1F2)),),
              onTap: () {
                Get.to(() => ProfileView(id: id, role: role));
              },
            ),
            SizedBox(height: 20),
            ListTile(
              tileColor: Color(0xFFF2C4E80),
              title: Text('Gestion des Quizs',style: TextStyle(color: Color(0xFFFF1F1F2)),),
              onTap: () {
                Get.to(() => GestionsView(id: id, role: role));
              },
            ),
            SizedBox(height: 250),
            ElevatedButton(
              onPressed: () {
                Get.to(() => HomeView(id: id, role: role));
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFF1F1F2)), // Utilisation d'une couleur plus contrastée
              ),
              child: Text(
                'Prendre Quiz',
                style: TextStyle(color: Color(0xFFF2C4E80), // Correction de la couleur du texte
              ),
            ),

            ),

          ],
        ),
      ),
    );
  }
}
