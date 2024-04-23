import 'package:codecrafter/app/modules/question/controllers/question_controller.dart';
import 'package:codecrafter/app/modules/quiz/controllers/quiz_controller.dart';
import 'package:codecrafter/app/services/niveauxservice.dart';
import 'package:codecrafter/app/services/questionservice.dart';
import 'package:codecrafter/app/services/quizservice.dart';
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
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.white
        ),
        useMaterial3: true,
      ),
      initialBinding: BindingsBuilder(() {
        Get.lazyPut(() => AuthService());
        Get.lazyPut(() => QuizzesService());
        Get.lazyPut(() => QuestionsService());
        Get.lazyPut(() => NiveauxService());
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
