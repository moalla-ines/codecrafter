import 'package:codecrafter/app/modules/question/views/question_view.dart';
import 'package:codecrafter/app/modules/quiz/controllers/quiz_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuizView extends GetView<QuizController> {
  final String? imageUrl;

  QuizView({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz List'),
      ),
      body: Obx(() {
        if (controller.quizzes.isEmpty) {
          return Center(child: CircularProgressIndicator());
        } else {
          return SingleChildScrollView(
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 10),
                    for (var quiz in controller.quizzes)
                      buildQuizTile(
                        context,
                        quiz.id.toString(),
                        quiz.titreQuiz!,
                        quiz.description!,
                        Colors.grey.shade200,
                        SizedBox(height: 2),
                        Container(padding: const EdgeInsets.all(3)),
                        imageUrl, // Utilisez l'URL de l'image passée en paramètre
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

  Widget buildQuizTile(BuildContext context, String tag, String title, String subtitle, Color tileColor, Widget? sizedBox, Widget? container, String? imageUrl) {
    return Column(
      children: [
        if (sizedBox != null) sizedBox,
        if (container != null) container,
        Hero(
          tag: tag,
          child: Material(
            child: ListTile(
              leading: imageUrl != null ? Image.network(imageUrl, width: 40, height: 40) : Icon(Icons.image),
              title: Text(title),
              subtitle: Text(subtitle),
              tileColor: tileColor,
              onTap: () {
                Get.to(() => QuestionView(quizId: tag)); // Passer l'ID du quiz à la vue des questions
              },
            ),
          ),
        ),
      ],
    );
  }
}

