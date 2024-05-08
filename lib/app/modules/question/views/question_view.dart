

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:codecrafter/app/model/model_questions.dart';
import 'package:codecrafter/app/modules/question/controllers/question_controller.dart';
import 'package:codecrafter/app/modules/score/views/score_view.dart';

class QuestionView extends GetView<QuestionController> {
  final int? quiz;
  int? id;
  String? role;
  QuestionView({this.quiz, this.id, this.role}) {
    if (quiz != null) {
      controller.fetchQuestionsByQuizzes(quiz!);
      print("role: $role");
    }
  }

  @override
  Widget build(BuildContext context) {

    final PageController _controller = PageController();


    controller.id = id;

    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text('Voulez-vous vraiment quitter ce quiz?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text('oui'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('Annuler'),
                ),
              ],
            );
          },
        ) ?? false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF732DA2),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF732DA2),
          title: Text(
            'Questions pour le quiz $quiz',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () async {
              bool leaveQuiz = await onWillPop(context);
              if (leaveQuiz) {
                controller.questions = [].obs;
                controller.color.value = Colors.white;
                controller.score = 0;
                Get.back();
              }
            },
          ),
          actions: role == "admin"
              ? [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                if (quiz != null) {
                  _showCreateQuestionDialog(context);
                } else {
                  Get.snackbar('Erreur', 'quiz est null');
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                final idquestion = controller.idQuestion;
                if (idquestion != null) {
                  controller.onDeleteQuestions(idquestion as int?);
                  Get.snackbar(
                      'Succès', 'Question supprimée avec succès !');
                }
              },
            ),
          ]
              : null,
        ),
        body: Obx(() {
          if (controller.questions.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else {
            return PageView.builder(
              controller: _controller,
              itemCount: controller.questions.length,
              itemBuilder: (context, index) {
                final question = controller.questions[index];
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Question ${index + 1}/${controller.questions.length}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey.shade200,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          question.text ?? 'Missing question text',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      SizedBox(height: 10),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: 4,
                        itemBuilder: (context, optionIndex) {
                          int optionNumber = optionIndex + 1;
                          return Card(
                            color: controller.color.value,
                            child: ListTile(
                              onTap: () {
                                _answerQuestion(
                                  controller,
                                  question,
                                  optionNumber,
                                  _controller,
                                  controller.questionNumber,
                                  controller.score,
                                  optionIndex + 1,
                                );
                              },
                              title: Text(question.getOption(optionNumber) ??
                                  'Missing option'),
                            ),
                          );
                        },
                      ),
                     role == "admin"
                         ?
                      Row(

                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (controller.questionNumber > 1)

                            IconButton(
                              icon: Icon(Icons.arrow_back,color: Colors.white),
                              onPressed: () {
                                _controller.previousPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.ease,
                                );
                                controller.questionNumber--;
                              },
                            ),
                          if (controller.questionNumber < controller.questions.length)
                            IconButton(
                              icon: Icon(Icons.arrow_forward ,color: Colors.white),
                              onPressed: () {
                                _controller.nextPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.ease,
                                );
                                controller.questionNumber++;

                              },
                            ),
                        ],
                      )
                    : Container(),
                    ],
                  ),
                );
              },
            );
          }
        }),
      ),
    );
  }

  Future<bool> onWillPop(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Voulez-vous vraiment quitter ce quiz?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('oui'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('Annuler'),
            ),
          ],
        );
      },
    ) ??
        false;
  }


  void _answerQuestion(
      QuestionController controller,
      Question question,
      int selectedOption,
      PageController _controller,
      int _questionNumber,
      int score,
      int optionIndex,
      ) {
    if (question.selectedOption == null) {
      controller.updateQuestion(question);
      if (selectedOption == question.indiceoptionCorrecte) {
        controller.score++;

        print("score est ${controller.score}");
      }

      if (selectedOption != null &&
          selectedOption == question.indiceoptionCorrecte) {
        controller.color.value = Colors.green;

      } else {
        controller.color.value = Colors.red;

      }
    }

    _nextQuestion(controller, _controller, score);
  }

  void _nextQuestion(
      QuestionController controller,
      PageController _controller,
      int score,
      ) {
    Future.delayed(Duration(seconds: 1), () {
      print( "numero : ${controller.questionNumber}"  );
      print(controller.questionNumber < controller.questions.length);
      if (controller.questionNumber < controller.questions.length) {
        _controller.nextPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.ease,
        );
        controller.questionNumber++;
        controller.nextQuestion();

      } else {
        print("Navigation vers ScoreView");
        Get.offAll(() => ScoreView(
          score: controller.score,
          totalQuestions: controller.questions.length,
          id: id,
          quiz: quiz,
          role: role,
        ));
      }
    });
  }


  void _showCreateQuestionDialog(BuildContext context) {
    final TextEditingController textController = TextEditingController();
    final TextEditingController option1Controller = TextEditingController();
    final TextEditingController option2Controller = TextEditingController();
    final TextEditingController option3Controller = TextEditingController();
    final TextEditingController option4Controller = TextEditingController();
    final TextEditingController indiceoptionCorrecteController =
    TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Créer une nouvelle question'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: textController,
                decoration: InputDecoration(labelText: 'Texte de la question'),
              ),
              TextField(
                controller: option1Controller,
                decoration: InputDecoration(labelText: 'Option 1'),
              ),
              TextField(
                controller: option2Controller,
                decoration: InputDecoration(labelText: 'Option 2'),
              ),
              TextField(
                controller: option3Controller,
                decoration: InputDecoration(labelText: 'Option 3'),
              ),
              TextField(
                controller: option4Controller,
                decoration: InputDecoration(labelText: 'Option 4'),
              ),
              TextField(
                controller: indiceoptionCorrecteController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Indice de la réponse correcte'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              int indiceOptionCorrecte =
                  int.tryParse(indiceoptionCorrecteController.text) ?? 0;
              if (quiz != null) {
                controller.onCreateQuestion(
                  textController.text,
                  option1Controller.text,
                  option2Controller.text,
                  option3Controller.text,
                  option4Controller.text,
                  indiceOptionCorrecte,
                  quiz!,
                );
              } else {
                Get.snackbar('Erreur', 'quiz est null');
              }
              Navigator.pop(context);
            },
            child: Text('Créer'),
          ),
        ],
      ),
    );
  }
}
