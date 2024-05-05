import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:codecrafter/app/model/model_questions.dart';
import 'package:codecrafter/app/services/questionservice.dart';

class QuestionController extends GetxController {
  final QuestionsService questionsService = Get.find();
  var currentQuestionIndex = 0.obs;
  var questions =[].obs;
  var selectedOption = 0.obs;
var score = 0;
  var color = Colors.white.obs;
int? id ;
  var selectedQuestions = <int>{}.obs;
  @override
  void onInit() {
    color.value = Colors.white;

    super.onInit();

  }

  Future<void> fetchQuestionsByQuizzes(int? quiz) async {
    try {
      final token = questionsService.token.value;
      final data = await questionsService.getQuestionsByQuizzes(quiz!);
      questions.assignAll(data
          .map((question) => Question(
        idquestion: question.idquestion,
        text: question.text,
        option1: question.option1,
        option2: question.option2,
        option3: question.option3,
        option4: question.option4,
        indiceoptionCorrecte: question.indiceoptionCorrecte,
      ))
          .toList());
    } catch (e) {
      print('Failed to fetch questions: $e');
    }
  }

  Question get currentQuestion => questions[currentQuestionIndex.value];
int ? get idQuestion =>  questions[currentQuestionIndex.value].idquestion;
  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      currentQuestionIndex++;
      selectedOption.value = 0;// Reset selected option
      color = Colors.white.obs;
    }
  }

  void answerQuestion(int selectedOption) {
    final question = currentQuestion;
    if (question.selectedOption == null) {
      if (selectedOption == question.indiceoptionCorrecte) {
        score++;
      }
      question.selectedOption = selectedOption;
      updateQuestion(question);
      nextQuestion();
    }
  }

  void updateQuestion(Question question) {
    final index =
    questions.indexWhere((q) => q.idquestion == question.idquestion);
    if (index != -1) {
      questions[index] = question;
    }
  }
  Future<void> onCreateQuestion(String text, String option1, String option2, String option3, String option4, int indiceoptionCorrecte, int? quiz) async {
    print(quiz);

    try {
      await questionsService.createQuestions(text, option1, option2, option3, option4, indiceoptionCorrecte, quiz!);

    } catch (e) {

      print('Error creating question: $e');
    }
  }
  void onDeleteQuestions(int? idquestion) async {
    try {
      await questionsService.deleteQuestions(idquestion!);
      update();
      Get.snackbar('Succès', 'question supprimé avec succès !');
    } catch (e) {
      Get.snackbar('Erreur', 'Échec de la suppression du question : $e');
    }
  }
  void toggleQuestionSelection(int idquestion) {
    if (selectedQuestions.contains(idquestion)) {
      selectedQuestions.remove(idquestion);
    } else {
      selectedQuestions.add(idquestion);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {

    super.onClose();
  }
}
