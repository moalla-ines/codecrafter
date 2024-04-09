import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  Future<String> authenticate(String email, String password) async {
    final url = Uri.parse('http://localhost:8080/api/v1/auth/authenticate');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final token = responseData['token'];
      return token;
    } else {
      throw Exception('Failed to authenticate');
    }
  }
}
