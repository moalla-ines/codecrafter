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
      final url = Uri.parse('http://172.20.10.2:8080/api/v1/questions/quiz/$quiz');
      print(quiz);

      final response = await http.get(url,
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
        print('Failed to load questions. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load questions');
      }
    } catch (e) {
      print('Exception occurred: $e');
      throw Exception('Failed to load questions');
    }
  }

  Future<void> createQuestions(String text, String option1,String option2,String option3,String option4,
      int indiceoptionCorrecte, int quiz) async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      final url = Uri.parse('http://172.20.10.2:8080/api/v1/questions');

      final response = await http.post(
        url,
        headers: <String, String>{
          "Accept": "application/json",
          'Content-Type': 'application/json; charset=utf-8',
          "Authorization": "Bearer $token",
        },
          body: jsonEncode(<String, dynamic>{
            'text': text,
            'option1': option1,
            'option2': option2,
            'option3': option3,
            'option4': option4,
            'indiceoptionCorrecte': indiceoptionCorrecte,
            'quiz': {'idquiz': quiz},
          }),

      );

      if (response.statusCode == 201) {
        print('Quiz created successfully');
        // Handle success as needed
      } else if (response.statusCode == 403) {
        throw Exception('Unauthorized');
      } else {
        print('Failed to create question. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Exception occurred: $e');
    }
  }
  Future<void> deleteQuestions(int idquestion) async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      final url = Uri.parse('http://172.20.10.2:8080/api/v1/questions/$idquestion');


      final response = await http.delete(
        url,
        headers: <String, String>{
          "Accept": "application/json",
          'Content-Type': 'application/json; charset=utf-8',
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 204) {
        print('Question deleted successfully');
        // Handle success as needed
      } else if (response.statusCode == 403) {
        throw Exception('Unauthorized');
      } else {
        print('Failed to delete question. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Exception occurred: $e');
    }
  }

  Future<void> updateQuestion(int? idquestion ,String text, String option1,String option2,String option3,String option4,
      int indiceoptionCorrecte, int? quiz) async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception('Token not found');
      }
      final url = Uri.parse('http://172.20.10.2:8080/api/v1/questions/$idquestion');

      final response = await http.put(
        url,
        headers: <String, String>{
          "Accept": "application/json",
          'Content-Type': 'application/json; charset=utf-8',
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(<String, dynamic>{
          'idquestion': idquestion,
          'text': text,
          'option1': option1,
          'option2': option2,
          'option3': option3,
          'option4': option4,
          'indiceoptionCorrecte': indiceoptionCorrecte,
          'quiz': {'idquiz': quiz},
        }),

      );

      if (response.statusCode == 200) {
        print(' naness moalla ${response.statusCode}');
        print('Question updated successfully');
        Get.snackbar('Succès', 'Question modifié avec succès !');
      } else if (response.statusCode == 403) {
        throw Exception('Unauthorized');
      } else {
        print('Failed to update question. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Exception occurred: $e');
    }
  }}

