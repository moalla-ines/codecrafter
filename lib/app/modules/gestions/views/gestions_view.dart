import 'package:codecrafter/app/modules/admin_gestions/views/admin_gestions_view.dart';
import 'package:codecrafter/app/modules/gestions/views/gestion_categorie.dart';
import 'package:codecrafter/app/modules/historique/views/historique_view.dart';
import 'package:codecrafter/app/modules/home/views/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:codecrafter/app/model/Quizzes.dart';
import 'package:codecrafter/app/modules/home/views/home_view.dart';
import 'package:codecrafter/app/modules/profile/views/profile_view.dart';
import 'package:codecrafter/app/modules/question/views/question_view.dart';
import 'package:codecrafter/app/modules/quiz/views/quiz_view.dart';
import '../controllers/gestions_controller.dart';

class GestionsView extends GetView<GestionsController> {
  String? role;
  int? id;
  final String? imageUrl;
  final int? index;

  GestionsView({this.role, this.id, this.imageUrl, this.index});

  @override
  Widget build(BuildContext context) {
    controller.id = id;
    controller.role = role;
    return Scaffold(
      backgroundColor: Color(0xFFFF1F1F2),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2C4E80),
        title: Text(
          'Gestion Quiz',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Color(0xFFFF1F1F2),
        child: Column(
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
      body: Obx(() {
        if (controller.quiz.isEmpty) {
          return Center(
            child: CircularProgressIndicator(color: const Color(0xFFF2C4E80)),
          );
        } else {
          return ListView.builder(
            itemCount: controller.quiz.length,
            itemBuilder: (context, index) {
              final quiz = controller.quiz[index];
              return _buildExpansionTile(context, quiz);
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFF2C4E80),
        onPressed: () {
          controller.fetchAllQuizzes();
        },
        child: Icon(Icons.refresh, color: Colors.white),
      ),
    );
  }

  Widget _buildExpansionTile(BuildContext context, Quiz quiz) {
    return ExpansionTile(
      title: Text(
        quiz.titreQuiz ?? 'Unknown',
        style: TextStyle(
          fontSize: 22,
          color: Color(0xFFF2C4E80),
        ),
      ),
      backgroundColor: Color(0xFFFF1F1F2),
      children: [
        ListTile(
          title: Text(
            'Cliquez ici pour gérer les quizs',
            style: TextStyle(
              color: Color(0xFFF2C4E80),
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
            ),
          ),
          onTap: () {
            Get.off(() => QuizView(
              niveau: quiz.niveau!.idNiveau,
              categorie: quiz.niveau!.categorie!.idcategorie,
              id: id,
              role: role,
              imageUrl: imageUrl,
            ));
          },
        ),
        ListTile(
          title: Text(
            'Categorie: ${quiz.niveau?.categorie?.titreCategorie ?? "Unknown"}',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Niveau: ${quiz.niveau?.name ?? "Unknown"}',
                  style: TextStyle(color: Colors.black, fontSize: 18)),
              Text('Quiz: ${quiz.titreQuiz ?? "Unknown"}',
                  style: TextStyle(color: Colors.black, fontSize: 18)),
              Text('Description: ${quiz.description ?? "Unknown"}',
                  style: TextStyle(color: Colors.black, fontSize: 18)),
              Text('Nombre de questions: ${quiz.nbQuestions ?? "Unknown"}',
                  style: TextStyle(color: Colors.black, fontSize: 18)),
            ],
          ),
        ),
        ListTile(
          title: Text(
            'Cliquez ici pour gérer les questions',
            style: TextStyle(
              color: Color(0xFFF2C4E80),
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
          onTap: () {
            Get.off(() => QuestionView(
              quiz: quiz.idquiz,
              id: id,
              role: role,
            ));
          },
        ),
      ],
    );
  }
}
