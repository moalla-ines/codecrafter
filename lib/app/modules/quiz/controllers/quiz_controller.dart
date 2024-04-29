import 'package:get/get.dart';

import 'package:codecrafter/app/services/quizservice.dart';
import 'package:codecrafter/app/model/Quizzes.dart'; // Assurez-vous d'importer correctement votre modèle QuizList

class QuizController extends GetxController {
  final QuizzesService quizzesService = Get.find();
  var quiz = [].obs;

  @override
  void onInit() {
    super.onInit();
  }

  void fetchQuizzesByNiveau(int? niveau) async {
    try {
      final token = quizzesService.token.value;
      final data = await quizzesService.getQuizzesByNiveau(niveau!);
      print(data);
      quiz.assignAll(data);
      print(quiz);
    } catch (e) {
      print('Failed to load quizzes: $e');
      // Gérer l'erreur comme vous le souhaitez
    }
  }
  void onCreateQuizzes(String titreQuiz, String description, int nbQuestions, int? niveau, int? categorie) async {
    try {

      await quizzesService.createQuizzes(titreQuiz, description, nbQuestions, niveau!, categorie!);
      Get.snackbar('Succès', 'Quiz créé avec succès !');
    } catch (e) {
      Get.snackbar('Erreur', 'Échec de la création du quiz : $e');
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