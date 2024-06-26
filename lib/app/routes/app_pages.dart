import 'package:codecrafter/app/modules/resetPassword/views/changePassword_view.dart';
import 'package:get/get.dart';

import '../modules/admin_gestions/bindings/admin_gestions_binding.dart';
import '../modules/admin_gestions/views/admin_gestions_view.dart';
import '../modules/gestions/bindings/gestions_binding.dart';
import '../modules/gestions/views/gestions_view.dart';
import '../modules/historique/bindings/historique_binding.dart';
import '../modules/historique/views/historique_view.dart';
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
import '../modules/score/bindings/score_binding.dart';
import '../modules/score/views/score_view.dart';
import '../modules/resetPassword/bindings/forgetPassword_binding.dart';
import '../modules/resetPassword/views/forgetPassword_view.dart';
import '../modules/resetPassword/controllers/forgetPassword_controller.dart';
import '../modules/resetPassword/views/changePassword_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
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
      page: () => InscriptionView(),
      binding: InscriptionBinding(),
    ),
    GetPage(
      name: _Paths.QUIZ,
      page: () => QuizView(),
      binding: QuizBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.NIVEAU,
      page: () => NiveauView(),
      binding: NiveauBinding(),
    ),
    GetPage(
      name: _Paths.QUESTION,
      page: () => QuestionView(),
      binding: QuestionBinding(),
    ),
    GetPage(
      name: _Paths.SCORE,
      page: () => ScoreView(),
      binding: ScoreBinding(),
    ),
    GetPage(
      name: _Paths.GESTIONS,
      page: () => GestionsView(),
      binding: GestionsBinding(),
    ),
    GetPage(
      name: _Paths.HISTORIQUE,
      page: () => HistoriqueView(),
      binding: HistoriqueBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_GESTIONS,
      page: () => AdminGestionsView(),
      binding: AdminGestionsBinding(),
    ),
    GetPage(
      name: _Paths.FORGET_PASSWORD,
      page: () => ForgotPasswordView(),
      binding: ForgetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => ChangePasswordView(),
      binding: ForgetPasswordBinding(),
    ),
  ];
}
