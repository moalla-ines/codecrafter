import 'package:codecrafter/app/services/quizhistoryService.dart';
import 'package:get/get.dart';

class HistoriqueController extends GetxController {

  final HistoriesService historiesService = Get.find();
  int? id;
  String? role;
  int? score;
  var quizHistory = [].obs;
  @override
  void onInit() {
    super.onInit();
  }

  void getAllQuizHistories() async {
    try {
      final token = historiesService.token.value;
      final data = await historiesService.getAllQuizHistory();

      print(data);
      quizHistory.assignAll(data);
      update();
    } catch (e) {
      print('Failed to load quizHistory: $e');
    }
  }
  void fetchQuizHistoriesByUser(int? user) async {
    try {
      print('123 $user');
      final token = historiesService.token.value;
      final data = await historiesService.getQuizHistoryByUser(user!);

      print(data);
      quizHistory.assignAll(data);
      update();
    } catch (e) {
      print('Failed to load quizHistory: $e');
    }
  }

  @override
  void onClose() {
    super.onClose();
  }


}
