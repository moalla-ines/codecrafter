import 'package:codecrafter/app/services/scoreservice.dart';
import 'package:get/get.dart';
import 'package:codecrafter/app/model/model_score.dart';


class ScoreController extends GetxController {
final ScoreService scoreService = Get.find();



  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }


Future<void> createScoreForQuestion(int idQuestion, Score score) async {
  try {
    Score createdScore = await scoreService.createScoreForQuestion(idQuestion, score);
    // Faire quelque chose avec le score créé si nécessaire
  } catch (e) {
    // Gérer les erreurs ici
    print('Failed to create score: $e');
  }
}
}