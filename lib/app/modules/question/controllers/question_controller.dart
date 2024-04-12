import 'package:codecrafter/app/model/model_questions.dart';
import 'package:get/get.dart';

class QuestionController extends GetxController {
  List<Questions> _questions = [];
  int index = 0;
  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // Ajouter une question initiale

    @override
    void onReady() {
      super.onReady();
    }

    @override
    void onClose() {
      super.onClose();
    }

    void increment() => count.value++;

    // Méthode pour ajouter une question
    void addQuestion(Questions question) {
      _questions.add(question);
    }
  }
}