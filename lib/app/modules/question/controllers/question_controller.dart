import 'package:codecrafter/app/model/model_questions.dart';
import 'package:codecrafter/app/services/questionservice.dart';
import 'package:get/get.dart';

class QuestionController extends GetxController {
  final QuestionsService questionsService = Get.find();
  List<Question> _questions = [];
  final questions = <Question>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchQuestionsByQuizzes(int quiz) async {
    try {
      questions.assignAll(await questionsService.getQuestionsByQuizzes(quiz));
      print(questions);
      print(quiz);
    } catch (e) {
      print('Failed to fetch questions: $e');
    }
  }


  void addQuestion(Question question) {
    _questions.add(question);
    update();
  }
}
