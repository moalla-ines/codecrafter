import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/historique_controller.dart';
import 'package:codecrafter/app/model/historiques.dart';
import 'package:codecrafter/app/modules/home/views/home_view.dart';
import 'package:codecrafter/app/modules/gestions/views/gestion_categorie.dart';
import 'package:codecrafter/app/modules/gestions/views/gestions_view.dart';
import 'package:codecrafter/app/modules/home/views/settings.dart';
import 'package:codecrafter/app/modules/profile/views/profile_view.dart';

class HistoriqueView extends GetView<HistoriqueController> {
  final int? id;
  final String? role;
  final int? score;

  HistoriqueView({this.id, this.role, this.score});

  @override
  Widget build(BuildContext context) {
    controller.role = role;
    controller.id = id;

    // Charger l'historique en fonction du rôle
    if (controller.role == "admin") {
      controller.getAllQuizHistories();
    } else {
      controller.fetchQuizHistoriesByUser(controller.id);
    }

    return Scaffold(

      backgroundColor: Color(0xFFFF1F1F2),
      appBar: AppBar(
        title: Text('Historique',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFFF2C4E80),
      ),

      drawer: Drawer(
        backgroundColor: Color(0xFFFF1F1F2),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFFF1F1F2),
              ),
              child: SizedBox(
                height: 50.0,
                child: Center(
                  child: Text(
                    'Gestionnaire',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            if (controller.role == "admin")
              ListTile(
                title: Text('Gestion Utilisateur'),
                onTap: () {
                  Get.off(() => ProfileView(role: role, id: id));
                },
              ),
            if (controller.role == "admin")
              ListTile(
                title: Text('Gestion Quizs'),
                onTap: () {
                  Get.off(() => GestionsView(role: role, id: id));
                },
              ),
            if (controller.role == "admin")
              ListTile(
                title: Text('Gestion Categorie'),
                onTap: () {
                  Get.off(() => GestionCategorieView(role: role, id: id));
                },
              ),

            if (controller.role == "admin")
              ListTile(
                title: Text('Gestion Profile'),
                onTap: () {
                  Get.off(() => SettingsView(role: role, id: id));
                },
              ),
            if (controller.role == "admin")
              ListTile(
                title: Text('Historique'),
                onTap: () {
                  Get.off(() => HistoriqueView(role: role, id: id));
                },
              ),
            if (controller.role == "admin")
              ListTile(
                title: Text('Prendre Quiz'),
                onTap: () {
                  Get.off(() => HomeView(role: role, id: id));
                },
              ),
            if (controller.role != "admin")
              ListTile(
                title: Text('Gestion Profile'),
                onTap: () {
                  Get.off(() => SettingsView(role: role, id: id));
                },
              ),

            if (controller.role != "admin")
              ListTile(
                title: Text('Historique'),
                onTap: () {
                  Get.off(() => HistoriqueView(role: role, id: id));
                },
              ),
            if (controller.role != "admin")
              ListTile(
                title: Text('Prendre Quiz'),
                onTap: () {
                  Get.off(() => HomeView(role: role, id: id));
                },
              ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        child: Obx(() {
          if (controller.quizHistory.isEmpty) {
            return Center(
              child: Text(
                'Aucun historique',
                style: TextStyle(color: Color(0xFFF2C4E80), fontSize: 30 ),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: controller.quizHistory.length,
              itemBuilder: (context, index) {
                final history = controller.quizHistory[index];
                return _buildExpansionTile(
                  context,
                  controller.role == "admin"
                      ? "Historique du quiz de ${history.user!.email}"
                      : "Mon quiz numéro ${index + 1}",
                  Color(0xFFFF1F1F2),
                  history,
                );
              },
            );
          }
        }),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Get.offAll(() => HomeView(id: id, role: role));
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              Color(0xFFF2C4E80)), // Utilisation d'une couleur plus contrastée
        ),
        child: Text(
          'Encore des quizs?',
          style: TextStyle(color: Color(0xFFFF1F1F2), fontSize: 10.00),
        ),
      ),
    );
  }

  Widget _buildExpansionTile(BuildContext context, String title, Color color,
      QuizHistory history) {
    return ExpansionTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          color: Color(0xFFF2C4E80),
        ),
      ),
      backgroundColor:Colors.grey.shade100,
      children: controller.role == "user"
          ? [
        ListTile(
          title: Text(
              'Categorie: ${history.quiz?.niveau?.categorie?.titreCategorie ??
                  "Unknown"}',style:TextStyle(color: Colors.black)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Niveau: ${history.quiz?.niveau?.name != null ? utf8.decode(history.quiz!.niveau!.name!.codeUnits) : "Unknown"}', style: TextStyle(color: Colors.black)),
              Text('Quiz: ${history.quiz?.titreQuiz ?? "Unknown"}',style:TextStyle(color: Colors.black)),
              Text('Score: ${history.result} %',style:TextStyle(color: Colors.black)),
            ],
          ),
        ),
      ]
          : [
        ListTile(
          title: Text(
              'Categorie: ${history.quiz?.niveau?.categorie?.titreCategorie ??
                  "Unknown"}',style:TextStyle(color: Colors.black)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Email: ${history.user!.username}',style:TextStyle(color: Colors.black)),
              Text('Niveau: ${history.quiz?.niveau?.name ?? "Unknown"}',style:TextStyle(color: Colors.black)),
              Text('Quiz: ${history.quiz?.titreQuiz ?? "Unknown"}',style:TextStyle(color: Colors.black)),
              Text('Score: ${history.result} %',style:TextStyle(color: Colors.black)),
            ],
          ),
        ),
      ],
    );
  }
}

