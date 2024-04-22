import 'package:codecrafter/app/model/model_questions.dart';
import 'package:get/get.dart';
 // Assurez-vous que le chemin d'importation est correct

class QuestionController extends GetxController {
  List<Question> _questions = [];

  void addQuestion(Question question) {
    _questions.add(question);
    update();
  }

// Ajoutez d'autres méthodes et propriétés selon vos besoins
}
