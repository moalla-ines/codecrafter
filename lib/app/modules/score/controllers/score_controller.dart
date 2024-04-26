import 'package:codecrafter/app/services/scoreservice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:codecrafter/app/model/model_score.dart';

class ScoreController extends GetxController {
  final ScoreService scoreService = Get.find();

  var totalQuestions = 0.obs;
  var score = 0.obs;

  // Méthode pour mettre à jour le score et le nombre total de questions
  void updateScore(int newScore, int newTotalQuestions) {
    score.value = newScore;
    totalQuestions.value = newTotalQuestions;
  }
  void resetQuiz() {
    score.value = 0;
    totalQuestions.value = 0;
  }

  // Méthode pour calculer le pourcentage de score arrondi
  int calculateRoundedPercentageScore() {
    if (totalQuestions.value == 0) {
      return 0;
    }
    double percentage = (score.value / totalQuestions.value) * 100;
    return percentage.round();
  }

  // Méthode pour obtenir un texte en fonction du score
  String getResultText() {
    int roundedPercentageScore = calculateRoundedPercentageScore();
    if (roundedPercentageScore >= 75) {
      return "You have Earned this Trophy";
    } else if (roundedPercentageScore < 75) {
      return "I know You can do better!!";
    } else {
      return "Good job!";
    }
  }

  // Méthode pour obtenir l'image en fonction du score
  String getResultImage() {
    int roundedPercentageScore = calculateRoundedPercentageScore();
    if (roundedPercentageScore >= 75) {
      return "assets/images/bouncy-cup.gif";
    } else if (roundedPercentageScore < 75) {
      return "assets/images/sad.png";
    } else {
      return "assets/images/neutral.png";
    }
  }

  // Méthode pour construire le widget Score en fonction du score arrondi
  Widget buildScoreWidget(BuildContext context) {
    int roundedPercentageScore = calculateRoundedPercentageScore();
    if (roundedPercentageScore != null && roundedPercentageScore >= 75) {
      return Column(
        children: [
          Text(
            "You have Earned this Trophy",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
          Image.asset(
            "assets/images/bouncy-cup.gif",
            fit: BoxFit.fill,
            height: MediaQuery.of(context).size.height * 0.25,
          ),
        ],
      );
    } else if (roundedPercentageScore != null && roundedPercentageScore <= 75) {
      return Column(
        children: [
          Text(
            "I know You can do better!!",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Image.asset(
            "assets/images/sad.png",
            fit: BoxFit.fill,
            height: MediaQuery.of(context).size.height * 0.25,
          ),
        ],
      );
    }

    // Return null if score is between 51 and 74, as there's no specific widget for that range
    return SizedBox.shrink();
  }

  // Méthode pour créer un score pour une question
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
