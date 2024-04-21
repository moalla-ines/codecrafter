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

  Future<List<Quizzes>> getQuizzesByNiveau(int niveau) async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception('Token not found');
      }
      final url = Uri.parse('http://localhost:8080/api/v1/quizzes/niveau/$niveau');
      final response = await http.get(
        url,
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept",
          "Authorization": "Bearer $token",
        },
      );
      if (response.statusCode == 200) {
        print(response.statusCode);
        final jsonData = jsonDecode(response.body) as List<dynamic>;
        print(response.body);
        return jsonData.map((json) => Quizzes.fromJson(json)).toList();

      } else {
        print(response.statusCode);
        print(response);
        throw Exception('Failed to load quizzes');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to load quizzes');
    }
  }

}
