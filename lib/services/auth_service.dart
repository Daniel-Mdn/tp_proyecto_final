import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tp_proyecto_final/model/jwt_token_model.dart';
import 'package:tp_proyecto_final/model/user_model.dart';
import 'package:tp_proyecto_final/services/storage_service.dart';

class AuthService {
  // Cambia esta URL por la de tu backend
  final String baseUrl = 'https://tubackend.com/api';
  final StorageService storageService;

    // Solo funciona para web
  Future<http.Response> simulateLogin() async {
    // key for encript = qwertyuiopasdfghjklzxcvbnm123456
    final resp = await http.get(Uri.parse('./assets/mockup_data/login.json'),
        headers: {
          "Strict-Transport-Security":
              "max-age=63072000; includeSubDomains; preload"
        });
    return resp;
  }

  Future<UserModel> getUserLogger() async {
    //TODO: Agregar endpoint que devuelve la info de un solo user
    final response = await http.get(Uri.parse('./assets/mockup_data/users.json'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      var usersList = UserModel.fromJson(jsonDecode(response.body)[0]);
      return usersList;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load users');
    }
  }

  /// Recupera el token almacenado
  Future<JwtPayload?> getToken() async {
    var token = await storageService.read('jwt_token');
    if (token != null) {
      return JwtPayload.fromToken(token);
    }
    return null;
  }

  /// Cierra sesión eliminando el token
  Future<bool> logout(BuildContext context) async {
    try {
      return storageService.delete('jwt_token');
    } catch (e) {
      print(e);
      return false;
    }
  }

  /// Método para iniciar sesión

  Future<bool> login(String email, String password) async {
    try {
      final url = Uri.parse('$baseUrl/auth/login');

      // Realiza la petición POST al backend
      // final response = await http.post(
      //   url,
      //   headers: {'Content-Type': 'application/json'},
      //   body: jsonEncode({'email': email, 'password': password}),
      // );
      final response = await simulateLogin();
      // Si la autenticación es exitosa, el backend debería devolver un JWT
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        if (token != null) {
          // Almacena el token de forma segura
          final result = await storageService.write(
            'jwt_token',
            token,
          );
          return result;
        }
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  AuthService({required this.storageService});
}
