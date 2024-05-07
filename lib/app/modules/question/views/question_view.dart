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
    int _questionNumber = 1;
    controller.id = id;
    return Scaffold(
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
          onPressed: () {
            controller.questions = [].obs;
            controller.color.value = Colors.white;
            controller.score = 0;
            Get.back();
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
              }),
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
                                index + 1,
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
                  ],
                ),
              );
            },
          );
        }
      }),
    );
  }

  void _answerQuestion(
      QuestionController controller,
      Question question,
      int selectedOption,
      PageController _controller,
      int _questionNumber,
      int score,
      int optionIndex) {
    if (question.selectedOption == null) {
      controller.updateQuestion(question);
      if (selectedOption == question.indiceoptionCorrecte) {
        // Increment score if the selected option is correct
        controller.score++;
        print("score est ${controller.score}");
      }

      if (selectedOption != null &&
          selectedOption == question.indiceoptionCorrecte) {
        controller.color.value =
            Colors.green; // Update color to green for correct answer
      } else {
        controller.color.value =
            Colors.red; // Update color to red for incorrect answer
      }
    }
    _nextQuestion(controller, _controller, _questionNumber, score);
  }

  void _nextQuestion(QuestionController controller, PageController _controller,
      int _questionNumber, int score) {
    Future.delayed(Duration(seconds: 1), () {
      if (_questionNumber < controller.questions.length) {
        _controller.nextPage(
            duration: Duration(milliseconds: 300), curve: Curves.ease);
        controller.nextQuestion();

        _questionNumber++;
        // Increment _questionNumber here
      } else {
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
                decoration:
                InputDecoration(labelText: 'Indice de la réponse correcte'),
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
                  quiz,
                );
              } else {
                // Handle the case where quiz is null
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
