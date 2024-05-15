import 'package:codecrafter/app/modules/home/views/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/historique_controller.dart';
import 'package:codecrafter/app/model/historiques.dart';
import 'package:codecrafter/app/modules/home/views/home_view.dart';

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
      drawer:
           Drawer
        (
        backgroundColor:Color(0xFFFF1F1F2),
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
            ListTile(
              title: Text('Gestion profil'),
              onTap: () {
                Get.to(() => SettingsView(role: role, id: id));
              },
            ),
            ListTile(
              title: Text('prondre quiz'),
              onTap: () {
                Get.to(() => HomeView(role: role, id: id));
              },
            ),
            ListTile(
              title: Text('Gestion profil'),
              onTap: () {
                Get.to(() => HistoriqueView(role: role, id: id));
              },
            ),
          ],
        ),
      ),
      body: Container(
        color: Color(0xFFF577B8D),
        padding: const EdgeInsets.all(30),
        margin: const EdgeInsets.all(30),
        child: Obx(() {
          if (controller.quizHistory.isEmpty) {
            return Center(child: Text('Aucun historique',style:TextStyle(color:Color(0xFFFF1F1F2) ),));
          } else {
            return ListView.builder(
              itemCount: controller.quizHistory.length,
              itemBuilder: (context, index) {
                final history = controller.quizHistory[index];
                return _buildExpansionTile(
                  context,
                  controller.role == "admin"
                      ? "Historique du quiz de ${history.user!.username}"
                      : "Mes quizs ${index + 1}",
                  Color(0xFFF2C4E80),
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
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFF2C4E80)), // Utilisation d'une couleur plus contrastée
        ),
        child: Text(
          'Encore des quizs?',
          style: TextStyle(color: Color(0xFFFF1F1F2), fontSize: 10.00),
        ),
      ),
    );
  }

  Widget _buildExpansionTile(
      BuildContext context,
      String title,
      Color color,
      QuizHistory history,
      ) {
    return ExpansionTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.grey.shade200,
      children: controller.role == "user"
          ? [
        ListTile(
          title: Text(
            'Catégorie: ${history.quiz?.niveau?.categorie?.titreCategorie ?? "Inconnu"}',
            style: TextStyle(color: Colors.black),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Niveau: ${history.quiz?.niveau?.name ?? "Inconnu"}',
                style: TextStyle(color: Colors.black),
              ),
              Text(
                'Quiz: ${history.quiz?.titreQuiz ?? "Inconnu"}',
                style: TextStyle(color: Colors.black),
              ),
              Text(
                'Score: ${history.result} %',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ]
          : [
        ListTile(
          title: Text(
            'Catégorie: ${history.quiz?.niveau?.categorie?.titreCategorie ?? "Inconnu"}',
            style: TextStyle(color: Colors.black),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Email: ${history.user!.username}',
                style: TextStyle(color: Colors.black),
              ),
              Text(
                'Niveau: ${history.quiz?.niveau?.name ?? "Inconnu"}',
                style: TextStyle(color: Colors.black),
              ),
              Text(
                'Quiz: ${history.quiz?.titreQuiz ?? "Inconnu"}',
                style: TextStyle(color: Colors.black),
              ),
              Text(
                'Score: ${history.result} %',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
