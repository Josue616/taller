import 'dart:convert';
import 'package:http/http.dart' as http;

class UserController {
  final String baseUrl = 'http://localhost:600';

  Future<String> authenticateUser(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data['success']
            ? 'Ingreso correcto'
            : 'Credenciales incorrectas';
      } else {
        return 'Error: ${response.statusCode}';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
}
