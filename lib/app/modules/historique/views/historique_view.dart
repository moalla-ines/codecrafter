import 'package:codecrafter/app/model/historiques.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/historique_controller.dart';

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
      backgroundColor: Color(0xFFF2C4E80),
      appBar: AppBar(
        title: Text(
          'Historique',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),

        ),
        centerTitle: true,
        backgroundColor: Color(0xFFF2C4E80),
      ),
      body:
      Container(
        color: Color(0xFFFF1F1F2),
        padding: const EdgeInsets.all(30),
        margin: const EdgeInsets.all(30),
        child: Obx(() {
          if (controller.quizHistory.isEmpty) {
            return Center(child: Text('Aucun historique'));
          } else {
            return ListView.builder(
              itemCount: controller.quizHistory.length,
              itemBuilder: (context, index) {
                final history = controller.quizHistory[index];
                return _buildExpansionTile(
                  context,
                  controller.role == "admin"
                      ? "Historique du quiz de ${history.user!.username}"
                      : "Mes quizs ${index}",
                  Color(0xFFF2C4E80),
                  history,
                );
              },
            );
          }
        }),
      ),
    );
  }

  Widget _buildExpansionTile(
      BuildContext context, String title, Color color, QuizHistory history) {
    return ExpansionTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.grey.shade100,
      children: controller.role == "user"
          ? [
        ListTile(
          title: Text(
              'Catégorie: ${history.quiz?.niveau?.categorie?.titreCategorie ?? "Inconnu"}',
              style: TextStyle(color: Colors.black)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Niveau: ${history.quiz?.niveau?.name ?? "Inconnu"}',
                  style: TextStyle(color: Colors.black)),
              Text('Quiz: ${history.quiz?.titreQuiz ?? "Inconnu"}',
                  style: TextStyle(color: Colors.black)),
              Text('Score: ${history.result} %',
                  style: TextStyle(color: Colors.black)),
            ],
          ),
        ),
      ]
          : [
        ListTile(
          title: Text(
              'Catégorie: ${history.quiz?.niveau?.categorie?.titreCategorie ?? "Inconnu"}',
              style: TextStyle(color: Colors.black)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Email: ${history.user!.username}',
                  style: TextStyle(color: Colors.black)),
              Text('Niveau: ${history.quiz?.niveau?.name ?? "Inconnu"}',
                  style: TextStyle(color: Colors.black)),
              Text('Quiz: ${history.quiz?.titreQuiz ?? "Inconnu"}',
                  style: TextStyle(color: Colors.black)),
              Text('Score: ${history.result} %',
                  style: TextStyle(color: Colors.black)),
            ],
          ),
        ),
      ],
    );
  }
}
