import 'package:codecrafter/app/modules/score/controllers/score_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResultsCard extends GetView<ScoreController> {
  final int roundedPercentageScore;
  final Color bgColor3;
  final int? score;

  ResultsCard({
    Key? key,
    required this.roundedPercentageScore,
    required this.bgColor3,
    this.score,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery
          .of(context)
          .size
          .width * 0.888,
      height: MediaQuery
          .of(context)
          .size
          .height * 0.568,
      child: Stack(
        children: [
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            for (var ii = 0;
                            ii < "Congratulations!,".length;
                            ii++) ...[
                              TextSpan(
                                text: "Congratulations!,"[ii],
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontSize: 12 + ii.toDouble()),
                              ),
                            ],
                            //m'adamfo(Twi) - my friend
                            TextSpan(
                              text: "  m'adamfo\n You Scored  \n",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodySmall,
                            ),
                            TextSpan(
                              text: "$roundedPercentageScore%",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: buildScoreWidget(context),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            left: -10,
            top: MediaQuery
                .of(context)
                .size
                .height * 0.178,
            child: Container(
              height: 25,
              width: 25,
              decoration:
              BoxDecoration(color: bgColor3, shape: BoxShape.circle),
            ),
          ),
          Positioned(
            right: -10,
            top: MediaQuery
                .of(context)
                .size
                .height * 0.178,
            child: Container(
              height: 25,
              width: 25,
              decoration:
              BoxDecoration(color: bgColor3, shape: BoxShape.circle),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildScoreWidget(BuildContext context) {
    if (roundedPercentageScore >= 75) {
      return Column(
        children: [
          Text(
            "You have Earned this Trophy",
            style: Theme
                .of(context)
                .textTheme
                .bodyLarge!
                .copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
          Image.asset(
            "assets/images/bouncy-cup.gif",
            fit: BoxFit.fill,
            height: MediaQuery
                .of(context)
                .size
                .height * 0.25,
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Text(
            "I know You can do better!!",
            style: Theme
                .of(context)
                .textTheme
                .bodyLarge!
                .copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Image.asset(
            "assets/images/sad.png",
            fit: BoxFit.fill,
            height: MediaQuery
                .of(context)
                .size
                .height * 0.25,
          ),
        ],
      );
    }
  }
}