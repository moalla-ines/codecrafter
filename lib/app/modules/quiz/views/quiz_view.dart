import 'package:codecrafter/app/modules/question/views/question_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:codecrafter/app/modules/quiz/controllers/quiz_controller.dart';

class QuizView extends GetView<QuizController> {
  final GlobalKey<NavigatorState> quizViewKey = GlobalKey<NavigatorState>();
  final String? imageUrl;

  QuizView({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: quizViewKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              backgroundColor: Color(0xFFF732DA2),
              appBar: AppBar(
                backgroundColor: Color(0xFFF732DA2),
                title: Text(
                  'Quiz',
                  style: TextStyle(color: Colors.grey.shade200, fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 10),
                        buildQuizTile(
                          context,
                          'Flutter quiz 1',
                          'Flutter quiz',
                          'questions concerning widgets',
                          Colors.grey.shade200,
                          SizedBox(height: 2),
                          Container(padding: const EdgeInsets.all(3)),
                          imageUrl,
                        ),
                        buildQuizTile(
                          context,
                          'Flutter quiz 2',
                          'Flutter quiz',
                          'questions concerning get cli',
                          Colors.grey.shade200,
                          SizedBox(height: 2),
                          Container(padding: const EdgeInsets.all(3)),
                          imageUrl,
                        ),
                        // Add more buildQuizTile calls as needed
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildQuizTile(BuildContext context, String tag, String title, String subtitle, Color tileColor, Widget? sizedBox, Widget? container, String? imageUrl) {
    return Column(
      children: [
        if (sizedBox != null) sizedBox,
        if (container != null) container,
        Hero(
          tag: tag,
          child: Material(
            child: ListTile(
              leading: imageUrl != null ? Image.asset(imageUrl, width: 40, height: 40) : Icon(Icons.image),
              title: Text(title),
              subtitle: Text(subtitle),
              tileColor: tileColor,
              onTap: () {
                Get.to(() => QuestionView());
              },
            ),
          ),
        ),
      ],
    );
  }
}

