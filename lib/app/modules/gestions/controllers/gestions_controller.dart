import 'package:codecrafter/app/services/quizservice.dart';
import 'package:get/get.dart';

class GestionsController extends GetxController {
  final QuizzesService quizzesService = Get.find();
  var quiz = [].obs;
  int? id;
  String? role;
  @override
  void onInit() {
    super.onInit();
  }

  void fetchAllQuizzes() async {
    try {
      final data = await quizzesService.getAllQuizzes();
      quiz.assignAll(data);
      print(data);
      update();
    } catch (e) {
      print('Failed to load quizzes: $e');
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

}
