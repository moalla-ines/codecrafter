

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
              backgroundColor: Colors.white,
              content: Text('Voulez-vous vraiment quitter ce quiz?',style:TextStyle(color: Color(0xFFF2C4E80))),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text('oui',style:TextStyle(color: Color(0xFFF2C4E80))),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('Annuler',style:TextStyle(color: Color(0xFFF2C4E80))),
                ),
              ],
            );
          },
        ) ?? false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFF1F1F2),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF2C4E80),
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
            icon: const Icon(Icons.arrow_back ,color: Colors.white),
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
              icon: const Icon(Icons.add ,color: Colors.white),
              onPressed: () {
                if (quiz != null) {
                  _showCreateQuestionDialog(context);
                } else {
                  Get.snackbar('Erreur', 'quiz est null');
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.white,),
              onPressed: () {
                final idquestion = controller.idQuestion;
                if (idquestion != null) {
                  controller.onDeleteQuestions(idquestion as int?);
                  Get.snackbar(
                      'Succès', 'Question supprimée avec succès !');
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.edit ,color: Colors.white,),
              onPressed: () {
                if (controller.questions.isNotEmpty) {
                  // Créer une liste de choix de questions
                  List<DropdownMenuItem<int>> questionItems = [];
                  for (int i = 0; i < controller.questions.length; i++) {
                    questionItems.add(
                      DropdownMenuItem(
                        value: i,
                        child: Text('Question ${i + 1}'),
                      ),
                    );
                  }

                  // Afficher une boîte de dialogue avec la liste des questions
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.white,
                      title: Text('Sélectionner une question à éditer '),
                      content: DropdownButton<int>(
                        items: questionItems,
                        onChanged: (value) {
                          var questionToUpdate = controller.questions[value!];
                          Navigator.pop(context); // Fermer la boîte de dialogue
                          if (questionToUpdate != null) {
                            _showCreateQuestionDialog(
                              context,
                              isUpdate: true,
                              question: questionToUpdate,
                            );
                          }
                        },
                      ),
                    ),
                  );
                } else {
                  Get.snackbar('Erreur', 'Aucune question à éditer');
                }
              },
            ),

          ]
              : null,
        ),
        body: Obx(() {
          if (controller.questions.isEmpty) {
            return Center(child: CircularProgressIndicator(color: const Color(0xFFFC9D7DD)));
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
                          'Question ${index + 1}/${controller.questions
                              .length}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,

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
                              icon: Icon(Icons.arrow_back, color: Colors.black),
                              onPressed: () {
                                _controller.previousPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.ease,
                                );
                                controller.questionNumber--;
                              },
                            ),
                          if (controller.questionNumber <
                              controller.questions.length)
                            IconButton(
                              icon: Icon(
                                  Icons.arrow_forward, color: Colors.black),
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


  void _answerQuestion(QuestionController controller,
      Question question,
      int selectedOption,
      PageController _controller,
      int _questionNumber,
      int score,
      int optionIndex,) {
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

  void _nextQuestion(QuestionController controller,
      PageController _controller,
      int score,) {
    Future.delayed(Duration(seconds: 1), () {
      print("numero : ${controller.questionNumber}");
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
        Get.offAll(() =>
            ScoreView(
              score: controller.score,
              totalQuestions: controller.questions.length,
              id: id,
              quiz: quiz,
              role: role,
            ));
      }
    });
  }


  void _showCreateQuestionDialog(BuildContext context,
      {bool isUpdate = false, Question? question})
{   final TextEditingController textController = TextEditingController();
    final TextEditingController option1Controller = TextEditingController();
  final TextEditingController option2Controller = TextEditingController();
    final TextEditingController option3Controller = TextEditingController();
    final TextEditingController option4Controller = TextEditingController();
    final TextEditingController indiceoptionCorrecteController = TextEditingController();

    if (isUpdate && question != null) {
      textController.text = question.text ?? '';
      option1Controller.text = question.getOption(1) ?? '';
      option2Controller.text = question.getOption(2) ?? '';
      option3Controller.text = question.getOption(3) ?? '';
      option4Controller.text = question.getOption(4) ?? '';
      indiceoptionCorrecteController.text =
          question.indiceoptionCorrecte?.toString() ?? '';
    } else {
      textController.text = '';
      option1Controller.text = '';
      option2Controller.text = '';
      option3Controller.text = '';
      option4Controller.text = '';
      indiceoptionCorrecteController.text = '';
    }

    showDialog(

      context: context,
      builder: (context) =>
          AlertDialog(
            backgroundColor: Colors.white,
            title: Text(isUpdate
                ? 'Modifier la question'
                : 'Créer une nouvelle question', style: TextStyle(color: Color(0xFFF2C4E80)),),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 10.0),
                  TextField(
                    controller: textController,
                    decoration: InputDecoration(
                        labelText: 'Texte de la question'    ,labelStyle: TextStyle(color: Color(0xFFF2C4E80)),),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller: option1Controller,
                    decoration: InputDecoration(labelText: 'Option 1',    labelStyle: TextStyle(color: Color(0xFFF2C4E80)),),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller: option2Controller,
                    decoration: InputDecoration(labelText: 'Option 2',    labelStyle: TextStyle(color: Color(0xFFF2C4E80)),),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller: option3Controller,
                    decoration: InputDecoration(labelText: 'Option 3',     labelStyle: TextStyle(color: Color(0xFFF2C4E80)),),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller: option4Controller,
                    decoration: InputDecoration(labelText: 'Option 4',    labelStyle: TextStyle(color: Color(0xFFF2C4E80)),),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller: indiceoptionCorrecteController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Indice de la réponse correcte',    labelStyle: TextStyle(color: Color(0xFFF2C4E80)),),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  int indiceOptionCorrecte = int.tryParse(
                      indiceoptionCorrecteController.text) ?? 0;
                  if (quiz != null) {
                    if (isUpdate) {
                      // Mettre à jour la question existante
                      controller.questionUpdated(
                        question!.idquestion,

                        textController.text,
                        option1Controller.text,
                        option2Controller.text,
                        option3Controller.text,
                        option4Controller.text,
                        indiceOptionCorrecte,
                        quiz!,
                      );
                    } else {
                      // Créer une nouvelle question
                      controller.onCreateQuestion(
                        textController.text,
                        option1Controller.text,
                        option2Controller.text,
                        option3Controller.text,
                        option4Controller.text,
                        indiceOptionCorrecte,
                        quiz!,
                      );
                    }
                    Navigator.pop(context);
                  } else {
                    Get.snackbar('Erreur', 'quiz est null');
                  }
                },
                child: Text(isUpdate ? 'Modifier' : 'Créer',style:TextStyle(color: Color(0xFFF2C4E80))),
              ),
            ],
          ),
    );
  }
}