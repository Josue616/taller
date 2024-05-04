import 'dart:convert';
import 'package:http/http.dart' as http;

class UserController {
  final String baseUrl = 'http://161.132.37.95:600';

  Future<String> authenticateUser(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['success']) {
          return 'Ingreso correcto';
        } else {
          return data['message'] ?? 'Credenciales incorrectas';
        }
      } else if (response.statusCode == 401) {
        return 'Usuario o contraseña incorrectos';
      } else {
        return 'Error de conexión: ${response.statusCode}';
      }
    } catch (e) {
      return 'Error de red: Por favor verifica tu conexión a internet';
    }
  }

  Future<String> registerUser(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 201) {
        return 'Registro exitoso';
      }
      if (response.statusCode == 409) {
        return 'El nombre de Usuario ya esta tomado';
      } else {
        var data = jsonDecode(response.body);
        return data['message'] ?? 'Error durante el registro';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
}
