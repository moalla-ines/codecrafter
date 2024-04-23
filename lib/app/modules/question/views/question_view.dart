import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/question_controller.dart';

class QuestionView extends GetView<QuestionController>{
  final int? quiz;

  QuestionView({this.quiz});

  @override
  Widget build(BuildContext context) {
    print(quiz);
    if (quiz == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Quiz ID is null'),
        ),
      );
    }

    return Scaffold(
        backgroundColor: const Color(0xFFF732DA2),
    appBar: AppBar(
    backgroundColor: const Color(0xFFF732DA2),
        title: Text('Questions pour le quiz $quiz' , style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
    ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          controller.questions.clear();
          Get.back();
        },
      ),
    ),

      body: Obx(() {
        if (controller.questions.isEmpty) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: controller.questions.length,
            itemBuilder: (context, index) {
              final question = controller.questions[index];
              String questionText =
                  question.text ?? 'Texte de la question manquant';
              return ListTile(
                title: Text(questionText),
                subtitle: Text(
                    'Option correcte: ${question.indiceOptionCorrecte ?? 'Indice manquant'}'),
              );
            },
          );
        }
      }),
    );
  }
}
