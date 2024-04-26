

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:codecrafter/app/model/model_questions.dart';
import 'package:codecrafter/app/modules/question/controllers/question_controller.dart';
import 'package:codecrafter/app/modules/score/views/score_view.dart';

class QuestionView extends GetView<QuestionController> {
  final int? quiz;

  int ?score;

  var globalScore;


  QuestionView({this.quiz}) {
    if (quiz != null) {
      controller.fetchQuestionsByQuizzes(quiz!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final PageController _controller = PageController();
    int _questionNumber = 1;


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
            controller.questions.clear();
            Get.back();
          },
        ),
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
                                controller.score.value, // Utilisez controller.score.value
                                optionIndex + 1,
                              );
                            },
                            title: Text(question.getOption(optionNumber) ?? 'Missing option'),
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
      int optionIndex,
      ) {
    if (question.selectedOption == null) {
      controller.updateQuestion(question);
      if (selectedOption == question.indiceoptionCorrecte) {
        // Increment score if the selected option is correct
        controller.score.value++; // Utilisez controller.score.value pour incrémenter le score
        print("score est ${controller.score.value}");
      }

      if (selectedOption != null &&
          selectedOption == question.indiceoptionCorrecte) {
        controller.color.value =
            Colors.green; // Update color to green for correct answer
      } else {
        controller.color.value =
            Colors.red; // Update color to red for incorrect answer
      }
      _nextQuestion(controller, _controller, _questionNumber, score);
    }
  }



  Color _getColor(int? selectedOption, int? correctOption, int optionIndex) {
    if (selectedOption != null) {
      if (selectedOption == correctOption) {
        return Colors.green; // Correct answer
      } else {
        return Colors.red; // Incorrect answer
      }
    }
    return Colors.white; // Default color
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
        Get.off(() => ScoreView(score: controller.score.value,
          totalQuestions: controller.questions.length,
        ));
      }
    });
  }
}