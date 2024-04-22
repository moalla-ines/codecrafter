import 'package:get/get.dart';

import 'package:codecrafter/app/services/quizservice.dart';
import 'package:codecrafter/app/model/Quizzes.dart'; // Assurez-vous d'importer correctement votre modèle QuizList

class QuizController extends GetxController {
  final QuizzesService quizzesService = Get.find();
  final quizzes = <Quizzes>[].obs;

  @override
  void onInit() {
    super.onInit();

  }

  void fetchQuizzesByNiveau(int? niveau) async {
    try {
      final token = quizzesService.token.value;
      final data = await quizzesService.getQuizzesByNiveau(niveau!);
      print(data);
      quizzes.assignAll(data);
      print(data);
    } catch (e) {
      print('Failed to load quizzes: $e');
      // Gérer l'erreur comme vous le souhaitez
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

