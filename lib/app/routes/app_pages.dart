import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/inscription/bindings/inscription_binding.dart';
import '../modules/inscription/views/inscription_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/niveau/bindings/niveau_binding.dart';
import '../modules/niveau/views/niveau_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/question/bindings/question_binding.dart';
import '../modules/question/views/question_view.dart';
import '../modules/quiz/bindings/quiz_binding.dart';
import '../modules/quiz/views/quiz_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.NIVEAU;

  static final routes = [
    GetPage(
      name: _Paths.QUIZ,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.INSCRIPTION,
      page: () => const InscriptionView(),
      binding: InscriptionBinding(),
    ),
    GetPage(
      name: _Paths.QUIZ,
      page: () =>  QuizView(),
      binding: QuizBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.NIVEAU,
      page: () =>  NiveauView(),
      binding: NiveauBinding(),
    ),
    GetPage(
      name: _Paths.QUESTION,
      page: () => const QuestionView(),
      binding: QuestionBinding(),
    ),
  ];
}
