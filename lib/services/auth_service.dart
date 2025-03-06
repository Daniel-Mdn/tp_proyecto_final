import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tp_proyecto_final/config/api_contants.dart';
import 'package:tp_proyecto_final/model/jwt_token_model.dart';
import 'package:tp_proyecto_final/model/user_model.dart';
import 'package:tp_proyecto_final/services/storage_service.dart';

class AuthService extends ChangeNotifier {
  // Cambia esta URL por la de tu backend
  final StorageService storageService;
  final Dio dio;

  AuthService({required this.storageService, required this.dio});

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
    try {
      final response = await dio.get(
        '/usuario/get',
      );
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.

        var userLogged = UserModel.fromJson(response.data);
        return userLogged;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load user');
      }
    } catch (e) {
      print('e in getUserLogger $e');
      throw Exception('Failed to load user');
    }
  }

  /// Recupera el token almacenado
  Future<String?> getToken() async {
    try {
      var token = await storageService.read('jwt_token');
      return token;
    } catch (e) {
      print('e in getToken $e');
      return null;
    }
  }

  Future<JwtPayload?> getTokenDecoded() async {
    try {
      var token = await storageService.read('jwt_token');
      if (token != null) {
        return JwtPayload.fromToken(token);
      }
      return null;
    } catch (e) {
      print('e in getTokenDecoded $e');
      return null;
    }
  }

  Future<bool> isJwtExpired() async {
    try {
      final token = await getTokenDecoded();
      if (token == null) {
        throw Exception('Token inválido');
      }
      final exp = token.exp;

      final now = DateTime.now().millisecondsSinceEpoch ~/
          1000; // Tiempo actual en segundos

      return now >= exp; // Retorna true si el token está vencido
    } catch (e) {
      print('Error al decodificar el token: $e');
      return true; // Si hay un error, asumimos que está vencido
    }
  }

  /// Método para iniciar sesión

  Future<bool> login(String email, String password) async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}/auth/login');
      final endpoint = http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': email, 'password': password}),
      );

      final response = await endpoint;
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
      print('e in login $e');
      return false;
    }
  }

  /// Cierra sesión eliminando el token
  Future<bool> logout(BuildContext context) async {
    try {
      return storageService.delete('jwt_token');
    } catch (e) {
      print('e in logout $e');
      return false;
    }
  }

  Future<bool> createUser(UserModel body) async {
    try {
      final response = await dio.post('/auth/registro', data: body.toJson());
      if (response.statusCode == 200) {
        final data = response.data;
        final token = data['token'];
        if (token != null) {
          // Almacena el token de forma segura
          final result = await storageService.write(
            'jwt_token',
            token,
          );
          return result;
        }
        return false;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to create user');
      }
    } catch (e) {
      print('e in createUser $e');
      return false;
    }
  }
}
