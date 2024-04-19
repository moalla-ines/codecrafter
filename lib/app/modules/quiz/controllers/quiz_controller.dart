import 'dart:convert';

import 'package:codecrafter/app/services/quizservice.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class QuizController extends GetxController {
  final QuizzesService quizzesService = Get.find();
  final quizzes = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchQuizzesByNiveau(1); // Appel initial pour récupérer les quiz pour le niveau 1
  }

  void fetchQuizzesByNiveau(int niveau) async {
    try {
      final token = quizzesService.token.value;
      final url = Uri.parse('http://localhost:8080/quizzes/niveau/$niveau');
      final response = await http.get(
        url,
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        quizzes.assignAll(jsonData); // Assurez-vous que jsonData est une liste
      } else {
        throw Exception('Failed to load quizzes');
      }
    } catch (e) {
      print(e.toString());
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
