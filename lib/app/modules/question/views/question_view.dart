import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:codecrafter/app/model/model_questions.dart';
import 'package:codecrafter/app/modules/question/controllers/question_controller.dart';
import 'package:codecrafter/app/modules/score/views/score_view.dart';

class QuestionView extends GetView<QuestionController> {
  final int? quiz;

  QuestionView({this.quiz});

  @override
  Widget build(BuildContext context) {
    final PageController _controller = PageController();
    int _questionNumber = 1;
    int score = 0;

    return Scaffold(
      backgroundColor: const Color(0xFFF732DA2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF732DA2),
        title: Text('Questions pour le quiz $quiz',textAlign: TextAlign.center, style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),),
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
          if (quiz != null) {
            controller.fetchQuestionsByQuizzes(quiz!);
          }
          return Center(child: CircularProgressIndicator());
        } else {
          final question = controller.currentQuestion;
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Question $_questionNumber/${controller.questions.length}',
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
                  itemBuilder: (context, index) {
                    int optionIndex = index + 1;
                    return Card(
                      color: _getColor(question.selectedOption, optionIndex),
                      child: ListTile(
                        onTap: () {
                          _answerQuestion(
                            controller,
                            question,
                            optionIndex,
                            _controller,
                            _questionNumber,
                            score,
                          );
                          print("nanes");
                        },
                        title: Text(question.getOption(optionIndex) ?? 'Missing option'),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        }
      }),
    );
  }

  void _answerQuestion(QuestionController controller, Question question,
      int selectedOption, PageController _controller, int _questionNumber,
      int score) {
    if (question.selectedOption == null) {
      controller.updateQuestion(question);
      if (selectedOption == question.indiceOptionCorrecte) {
        score++;
      }
      _nextQuestion(controller, _controller, _questionNumber, score);
    }
  }

  Color _getColor(int? selectedOption, int optionIndex) {
    if (selectedOption == optionIndex) {
      return Colors.green;
    }
    return Colors.white;
  }

  void _nextQuestion(QuestionController controller, PageController _controller,
      int _questionNumber, int score) {
    Future.delayed(Duration(seconds: 1), () {
      if (_questionNumber < controller.questions.length) {
        _controller.nextPage(
            duration: Duration(milliseconds: 300), curve: Curves.ease);
        controller
            .nextQuestion(); // Utilisation de la méthode du contrôleur pour mettre à jour le numéro de question
      } else {
        Get.off(() => ScoreView(
          score: score,
          totalQuestions: controller.questions.length,
        ));
      }
    });
  }
}
