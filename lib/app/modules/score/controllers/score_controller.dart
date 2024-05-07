import 'package:codecrafter/app/services/scoreservice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:codecrafter/app/model/model_score.dart';

class ScoreController extends GetxController {
  final ScoreService scoreService = Get.find();

  var totalQuestions = 0.obs;
  var score = 0;

  // Méthode pour mettre à jour le score et le nombre total de questions
  void updateScore(int newScore, int newTotalQuestions) {
    score = newScore;
    totalQuestions.value = newTotalQuestions;
  }

  // Méthode pour calculer le pourcentage de score arrondi
  int calculateRoundedPercentageScore() {
    if (totalQuestions.value == 0) {
      return 0;
    }
    double percentage = (score / totalQuestions.value) * 100;
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
  Future<void> onCreateHistory(int result, int? user, int? quiz) async {
    try {
      print(user);
      print(quiz);
      if (user == null || quiz == null) {
        throw Exception('User ID or quiz ID is null');
      }

      // Appel à la méthode pour créer l'historique du quiz
      await scoreService.createQuizHistory(result, user, quiz);

      // Par exemple, mettre à jour l'interface utilisateur ou afficher un message de succès
      Get.snackbar('Success', 'History created successfully');
    } catch (e) {
      // Gérer les erreurs ici
      print('Failed to create history: $e');

      // Afficher un message d'erreur à l'utilisateur
      Get.snackbar('Error', 'Failed to create history: $e');
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
