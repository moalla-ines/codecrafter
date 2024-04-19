import 'dart:convert';
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
    return _token!.value;
  }

  Future<List<dynamic>> getQuizzesByNiveau(int niveau) async {
    final token = await getToken();
    if (token == null) {
      throw Exception('Token not found');
    }
    final url = Uri.parse('http://localhost:8080/quizzes/niveau/$niveau');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return jsonData;
    } else {
      throw Exception('Failed to load quizzes');
    }
  }
}
