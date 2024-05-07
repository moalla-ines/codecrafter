import 'package:codecrafter/app/modules/question/views/question_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:codecrafter/app/model/Quizzes.dart';
import '../controllers/gestions_controller.dart';


class GestionsView extends GetView<GestionsController> {
  String? role;
  int? id;

  GestionsView({String? role, this.id});

  @override
  Widget build(BuildContext context) {
    controller.id = id;
    controller.role = role;
    return Scaffold(
      backgroundColor: Color(0xFFFe4c1f9),
      appBar: AppBar(
        backgroundColor: Color(0xFFF735DA5),
        title: Text(
          'Gestion Quiz',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      drawer: controller.role == "admin"
          ? Drawer(
        backgroundColor: Color(0xFFFc19ee0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFFe4c1f9),
              ),
              child: SizedBox(
                height: 50.0,
                child: Center(
                  child: Text(
                    'Gestionnaire',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text('Gestion utilisateur'),
              onTap: () {
                // Action à effectuer lors du clic sur cet élément
              },
            ),
            ListTile(
              title: Text('Gestion Quizs'),
              onTap: () {
                // Action à effectuer lors du clic sur cet élément
              },
            ),
            ListTile(
              title: Text('Gestion Questions'),
              onTap: () {
                // Action à effectuer lors du clic sur cet élément
              },
            ),
          ],
        ),
      )
          : null,
      body: Obx(() {
        if (controller.quiz.isEmpty) {
          return Center(
            child: CircularProgressIndicator(),
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
        onPressed: () {
          controller.fetchAllQuizzes();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildExpansionTile(BuildContext context, Quiz quiz) {
    return ExpansionTile(
      title: Text(
        quiz.titreQuiz ?? 'Unknown',
        style: TextStyle(
            fontSize: 22,
            color: Color(0xFFF735DA5),
            fontWeight: FontWeight.w500),
      ),
      backgroundColor: Color(0xFFFe4c1f9),
      children: [
        ListTile(
          title: Text(
            'Categorie: ${quiz.niveau?.categorie?.titreCategorie ?? "Unknown"}',
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Niveau: ${quiz.niveau?.name ?? "Unknown"}'),
              Text('Quiz: ${quiz.titreQuiz ?? "Unknown"}'),
              Text('Description: ${quiz.description ?? "Unknown"}'),
              Text('Nombre de questions: ${quiz.nbQuestions ?? "Unknown"}'),
            ],
          ),
        ),
        ListTile(
          title: Text('Cliquez ici pour gérer les questions'),
          onTap: () {
            Get.to(QuestionView(quiz: quiz.idquiz, id: id, role: role));
          },
        ),
      ],
    );
  }
}
