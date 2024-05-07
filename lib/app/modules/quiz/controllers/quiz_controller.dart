import 'package:get/get.dart';

import 'package:codecrafter/app/services/quizservice.dart';
import 'package:codecrafter/app/model/Quizzes.dart'; // Assurez-vous d'importer correctement votre modèle QuizList

class QuizController extends GetxController {
  final QuizzesService quizzesService = Get.find();
  var quiz = [].obs;
  var selectedQuizzes = <int>{}.obs;
  String? role;
  int? id ;
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
      update();
      print(quiz);
      print(role);
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

  void onDeleteQuiz(int idquiz) async {
    try {
      await quizzesService.deleteQuizzes(idquiz);
      update();
      Get.snackbar('Succès', 'Quiz supprimé avec succès !');
    } catch (e) {
      Get.snackbar('Erreur', 'Échec de la suppression du quiz : $e');
    }
  }
  void onUpdateQuiz(int idquiz, String titreQuiz, String description, int nbQuestions, int? niveau, int? categorie) async {
    print(idquiz);
    try {
      if (niveau != null && categorie != null) {
        await quizzesService.updateQuiz(idquiz, titreQuiz, description, nbQuestions, niveau, categorie);
        update();
        Get.snackbar('Succès', 'Quiz modifié avec succès !');
      } else {
        Get.snackbar('Erreur', 'Niveau ou catégorie est null');
      }
    } catch (e) {
      Get.snackbar('Erreur', 'Échec de la modification du quiz : $e');
    }
  }

  void toggleQuizSelection(int idquiz) {
    if (selectedQuizzes.contains(idquiz)) {
      selectedQuizzes.remove(idquiz);
    } else {
      selectedQuizzes.add(idquiz);
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