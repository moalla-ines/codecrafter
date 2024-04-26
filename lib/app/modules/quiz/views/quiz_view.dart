

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:codecrafter/app/model/Quizzes.dart';
import 'package:codecrafter/app/modules/question/views/question_view.dart';
import 'package:codecrafter/app/modules/quiz/controllers/quiz_controller.dart';

class QuizView extends GetView<QuizController> {
  final String? imageUrl;
  final int? niveau;

  QuizView({this.imageUrl, this.niveau});

  var context;

  @override
  Widget build(BuildContext context) {
    print(niveau);
    return Scaffold(
      backgroundColor: const Color(0xFFF732DA2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF732DA2),
        title: const Text(
          'Quiz List',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            controller.quiz = [].obs;
            Get.back();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showCreateQuizDialog(context);
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.quiz.isEmpty) {
          if (niveau != null) {
            controller.fetchQuizzesByNiveau(niveau!);
          }
          return const Center(child: CircularProgressIndicator());
        } else {
          return SingleChildScrollView(
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var quiz in controller.quiz)
                      buildQuizTile(
                        context,
                        quiz.idquiz.toString(),
                        quiz.titreQuiz ?? '',
                        quiz.description ?? '',
                        Colors.grey.shade200,
                        SizedBox(height: 2),
                        Container(padding: const EdgeInsets.all(3)),
                        imageUrl,
                        quiz,
                      ),
                  ],
                ),
              ),
            ),
          );
        }
      }),
    );
  }

  Widget buildQuizTile(BuildContext context,
      String tag,
      String title,
      String subtitle,
      Color tileColor,
      Widget? sizedBox,
      Widget? container,
      String? imageUrl,
      Quiz quiz,) {
    return Column(
      children: [
        if (sizedBox != null) sizedBox,
        if (container != null) container,
        Hero(
          tag: tag,
          child: Material(
            child: ListTile(
              leading: imageUrl != null
                  ? Image.network(imageUrl, width: 40, height: 40)
                  : const Icon(Icons.image),
              title: Text(title),
              subtitle: Text(subtitle),
              tileColor: tileColor,
              onTap: () {
                Get.to(() => QuestionView(quiz: quiz.idquiz));
              },
            ),
          ),
        ),
      ],
    );
  }

  // Method to display the create quiz dialog
  void _showCreateQuizDialog(BuildContext context) {
    final TextEditingController titleQuizController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text('Créer un nouveau quiz'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleQuizController,
                  decoration: InputDecoration(labelText: 'Titre'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  controller.onCreateQuizzes(
                    titleQuizController.text,
                    descriptionController.text,
                  );
                  Navigator.pop(context); // Fermer la boîte de dialogue
                },
                child: Text('Créer'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(
                      context); // Fermer la boîte de dialogue sans créer le quiz
                },
                child: Text('Annuler'),
              ),
            ],
          ),
    );
  }
}