import 'package:codecrafter/app/model/model_niveau.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
class NiveauxService extends GetxService{
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
  Future<List<Niveau>> getNiveauByCategorie(int categorie) async {
    try {
      final token = await getToken();

      if (token == null) {
        throw Exception('Token not found');
      }
      final url = Uri.parse('http://localhost:8080/api/v1/niveau/categorie/$categorie');
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
        final jsonData = jsonDecode(response.body) as List<dynamic>;
        return jsonData.map((json) => Niveau.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load niveaux');
      }

    } catch (e) {

      throw Exception('Failed to load niveaux');
    }
  }

}

