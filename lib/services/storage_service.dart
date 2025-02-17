import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  // Instancia para el almacenamiento seguro
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future getAll() async {
    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      return prefs;
    } else {
      return await _storage.readAll();
    }
  }


  Future<String?> read(String key) async {
    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      print('prefs');
      print(prefs.toString());
      print('prefs.toString()');

      return prefs.getString('jwt_token');
    } else {
      return await _storage.read(key: 'jwt_token');
    }
  }

  Future<bool> write(String key, String data) async {
    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      return prefs.setString(key, data);
    } else {
      await _storage.write(
        key: 'jwt_token',
        value: 'token',
      );
      return true;
    }
  }

  /// Cierra sesión eliminando el token
  Future<bool> delete(String key) async {
    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      return prefs.remove(key);
    } else {
      await _storage.delete(key: 'jwt_token');
      return true;
    }
  }
}
