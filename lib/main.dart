import 'package:codecrafter/app/modules/gestions/controllers/gestions_controller.dart';
import 'package:codecrafter/app/modules/profile/controllers/profile_controller.dart';
import 'package:codecrafter/app/modules/question/controllers/question_controller.dart';
import 'package:codecrafter/app/modules/quiz/controllers/quiz_controller.dart';
import 'package:codecrafter/app/modules/score/controllers/score_controller.dart';
import 'package:codecrafter/app/services/niveauxservice.dart';
import 'package:codecrafter/app/services/questionservice.dart';
import 'package:codecrafter/app/services/quizhistoryService.dart';
import 'package:codecrafter/app/services/quizservice.dart';
import 'package:codecrafter/app/services/scoreservice.dart';
import 'package:codecrafter/app/services/userservice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/modules/niveau/controllers/niveau_controller.dart';
import 'app/routes/app_pages.dart';

import 'app/modules/home/controllers/home_controller.dart';
import 'app/modules/login/controllers/login_controller.dart';
import 'app/modules/inscription/controllers/inscription_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'codecrafter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Définir les couleurs de texte par défaut
        textTheme: TextTheme(
          // Utiliser une couleur de texte blanche
          bodyText1: TextStyle(color: Colors.white),
        ),
        // Définir le thème des champs de texte
        inputDecorationTheme: InputDecorationTheme(
          // Utiliser une bordure blanche pour les champs de texte
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          // Définir le style des étiquettes
          labelStyle: TextStyle(color: Colors.white),
          // Définir le style des astuces
          hintStyle: TextStyle(color: Colors.white),
        ),
      ),


      initialBinding: BindingsBuilder(() {
        Get.lazyPut(() => AuthService());
        Get.lazyPut(() => HistoriesService());
        Get.lazyPut(() => QuizzesService());
        Get.lazyPut(() => QuestionsService());
        Get.lazyPut(() => NiveauxService());
        Get.lazyPut(() => ScoreService());
        Get.put(ScoreController());
        Get.put(ProfileController());
        Get.put(GestionsController());
        Get.put(HomeController());
        Get.put(QuizController());
        Get.put(QuestionController());
        Get.put(NiveauController());
        Get.put(LoginController());
        Get.put(InscriptionController());
      }),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
