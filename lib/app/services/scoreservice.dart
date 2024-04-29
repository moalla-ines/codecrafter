import 'dart:convert';

import 'package:codecrafter/app/model/model_score.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ScoreService extends GetxService {
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

  Future<Score> createScoreForQuestion(int question, Score score) async {
    try {
      // Récupérer le token
      String? token = await getToken();

      if (token != null) {
        // Construire l'URL pour l'API
        String url = 'http://localhost:8080/api/v1/score/questions/$question';

        // Convertir l'objet Score en JSON
        String scoreJson = jsonEncode(score.toJson());

        // Envoyer la requête POST avec le score JSON et le token dans l'en-tête
        http.Response response = await http.post(
          Uri.parse(url),
          headers: <String, String>{
            "Accept": "application/json",
            'Content-Type': 'application/json; charset=utf-8',
            "Authorization": "Bearer $token",
          },
          body: scoreJson,
        );

        // Vérifier le statut de la réponse
        if (response.statusCode == 201) {
          // Si la création du score est réussie, renvoyer le score créé
          Map<String, dynamic> responseData = jsonDecode(response.body);
          Score createdScore = Score.fromJson(responseData);
          return createdScore;
        } else {
          // Si la création du score a échoué, afficher une erreur
          throw Exception('Failed to create score');
        }
      } else {
        throw Exception('Token not available');
      }
    } catch (e) {
      print('Exception occurred: $e');
      throw Exception('Failed to create score');
    }
  }
}