import 'package:codecrafter/app/model/model_score.dart';
import 'package:codecrafter/app/modules/home/views/home_view.dart';
import 'package:codecrafter/app/modules/score/views/result_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import '../controllers/score_controller.dart';
import '../../question/controllers/question_controller.dart '
as question_controller;

class ScoreView extends GetView<ScoreController> {
  int? totalQuestions;
  int? score;
  int? idquestion;
  int? id;
  int result = 0; // Ajout de l'attribut result
  final int? quiz;
  final int? user;
  String? role;
  ScoreView(
      {this.score,
        this.totalQuestions,
        this.idquestion,
        this.id,
        this.quiz,
        this.user,
        this.role});

  @override
  Widget build(BuildContext context) {
    const Color bgColor3 = Color(0xFFF732DA2);
    final double percentageScore = (score! / totalQuestions!) * 100;

    final int roundedPercentageScore = percentageScore.round();
    print(roundedPercentageScore);
    const Color cardColor = Color(0xFFF732DA2);
    return WillPopScope(
      onWillPop: () {
        Navigator.popUntil(context, (route) => route.isFirst);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: bgColor3,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: bgColor3,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Results On Your ",
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    for (var i = 0; i < "Score!!!".length; i++) ...[
                      TextSpan(
                        text: "Score!!!"[i],
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: 18 + i.toDouble(),
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ]
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Your Score: $score/$totalQuestions",
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Column(
                children: [
                  ResultsCard(
                    roundedPercentageScore: roundedPercentageScore,
                    bgColor3: bgColor3,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(cardColor),
                      fixedSize: MaterialStateProperty.all(
                        Size(MediaQuery.of(context).size.width * 0.80, 40),
                      ),
                      elevation: MaterialStateProperty.all(4),
                    ),
                    onPressed: () {
                      result = roundedPercentageScore;
                      if (id != null && quiz != null) {
                        print("idUSER: $id");
                        print("idQUIZ: $quiz");
                        controller.onCreateHistory(result, id, quiz);
                        score = 0;
                        Get.to(HomeView(id: id, role: role));
                      } else {
                        print("User ID or quiz ID is null");
                        // Gérer cette erreur de manière appropriée
                      }
                    },
                    child: const Text(
                      "Take another test",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
