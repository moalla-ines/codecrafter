import 'package:get/get.dart';
import 'package:codecrafter/app/model/model_questions.dart';
import 'package:codecrafter/app/services/questionservice.dart';

class QuestionController extends GetxController {
  final QuestionsService questionsService = Get.find();
  var currentQuestionIndex = 0.obs;
  var questions = <Question>[].obs;
  var selectedOption = 0.obs;
  var score = 0.obs;

  @override
  void onInit() {
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
        indiceOptionCorrecte: question.indiceOptionCorrecte,
      ))
          .toList());
    } catch (e) {
      print('Failed to fetch questions: $e');
    }
  }

  Question get currentQuestion => questions[currentQuestionIndex.value];

  void nextQuestion() {
    currentQuestionIndex++;
    selectedOption.value = 0; // Reset selected option
  }

  void answerQuestion(int selectedOption) {
    final question = currentQuestion;
    if (question.selectedOption == null) {
      if (selectedOption == question.indiceOptionCorrecte) {
        score++;
      }
      question.selectedOption = selectedOption;
      updateQuestion(question);
      nextQuestion();
    }
  }

  void updateQuestion(Question question) {
    final index = questions.indexWhere((q) => q.idquestion == question.idquestion);
    if (index != -1) {
      questions[index] = question;
    }
  }
}