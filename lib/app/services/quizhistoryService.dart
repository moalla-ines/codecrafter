import 'dart:convert';

import 'package:codecrafter/app/model/historiques.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HistoriesService extends GetxService {
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

  Future<List<QuizHistory>> getQuizHistoryByUser(int user) async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      final url = Uri.parse(
          'http://172.20.10.2:8080/api/v1/quiz-history/user/$user');
      final response = await http.get(
        url,
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as List<dynamic>;
        return jsonData.map((json) => QuizHistory.fromJson(json)).toList();
      } else {
        print(
            'Failed to load quizhistory. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load quizhistory');
      }
    } catch (e) {
      print('Exception occurred: $e');
      throw Exception('Failed to load quizhistory');
    }
  }
  Future<List<QuizHistory>> getAllQuizHistory() async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      final url = Uri.parse(
          'http://172.20.10.2:8080/api/v1/quiz-history');
      final response = await http.get(
        url,
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as List<dynamic>;
        return jsonData.map((json) => QuizHistory.fromJson(json)).toList();
      } else {
        print(
            'Failed to load quizhistory. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load quizhistory');
      }
    } catch (e) {
      print('Exception occurred: $e');
      throw Exception('Failed to load quizhistory');
    }
  }
}
