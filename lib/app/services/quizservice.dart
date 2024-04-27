import 'dart:convert';

import 'package:codecrafter/app/model/Quizzes.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class QuizzesService extends GetxService {
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

  Future<List<Quiz>> getQuizzesByNiveau(int niveau) async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception('Token not found');
      }
      final url = Uri.parse('http://localhost:8080/api/v1/quiz/niveau/$niveau');

      final response = await http.get(
        url,
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as List<dynamic>;
        return jsonData.map((json) => Quiz.fromJson(json)).toList();
      } else {
        print('Failed to load quizzes. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load quizzes');
      }
    } catch (e) {
      print('Exception occurred: $e');
      throw Exception('Failed to load quizzes');
    }
  }

  Future<void> createQuizzes(String titreQuiz, String description, int nbQuestions) async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      final url = Uri.parse('http://localhost:8080/api/v1/quiz/create');

      final response = await http.post(
        url,
        headers: <String, String>{
          "Accept": "application/json",
          'Content-Type': 'application/json; charset=utf-8',
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(<String, dynamic>{
          'titre_quiz': titreQuiz,
          'description': description,
          'nb_questions': nbQuestions,
        }),
      );

      if (response.statusCode == 201) {
        print('Quiz created successfully');
        // Handle success as needed
      } else if (response.statusCode == 403) {
        throw Exception('Unauthorized');
      } else {
        print('Failed to create quiz. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Exception occurred: $e');
    }
  }

}
