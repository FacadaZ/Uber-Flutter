import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiProvider {
  final String _baseUrl = 'http://143.198.16.180/api/auth';

  Future<String?> login(String email, String password) async {
    final url = Uri.parse('$_baseUrl/loginuser');
    final response = await http.post(url, body: {
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final String token = jsonResponse['access_token'];

      // Almacenar el token en el almacenamiento local
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);

      return token;
    } else {
      return null;
    }
  }

  Future<void> register(String fullname, String email, String password) async {
    final url = Uri.parse('$_baseUrl/registeruser');
    final response = await http.post(url, body: {
      'fullname': fullname,
      'email': email,
      'password': password,
    });

    if (response.statusCode != 201) {
      // Decodifica la respuesta para obtener el mensaje de error
      final jsonResponse = json.decode(response.body);
      final String errorMessage =
          jsonResponse['error'] ?? 'Unknown error occurred';
      throw Exception('Failed to register: $errorMessage');
    }
  }
}
