import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class ClienteService {
  final client = http.Client();

  Future<String> getTrips() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found');
    } else {
      print('Token: $token');
    }

    var url = Uri.parse('http://143.198.16.180/api/trips');
    var response = await client.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      return response.body;
    } else {
      print('Error body: ${response.body}');
      throw Exception('Failed to load trips');
    }
  }
}
