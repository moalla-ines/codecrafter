import 'package:codecrafter/app/model/model_questions.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class QuestionsService extends GetxService{
  RxString _token = RxString('');
  RxString get token => _token;

  void setToken(String token) {
    _token.value = token;
  }

  void clearToken() {
    _token.value = '';
  }

  Future<String?> getToken() async {
    // Simuler une récupération de token (à remplacer par votre propre logique)
    await Future.delayed(Duration(seconds: 1));
    return _token.value;
  }
  Future<List<Question>> getQuestionsByQuizzes(int quiz) async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception('Token not found');
      }
      final url = Uri.parse('http://localhost:8080/api/v1/questions/quizzes/$quiz');
      print(quiz);
      final response = await http.get(
        url,
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as List<dynamic>;
        return jsonData.map((json) => Question.fromJson(json)).toList();
      } else {
        print('Failed to load quizzes. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load questions');
      }
    } catch (e) {
      print('Exception occurred: $e');
      throw Exception('Failed to load questions');
    }
  }


}
