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
      return prefs.getString(key);
    } else {
      return await _storage.read(key: key);
    }
  }

  Future<bool> write(String key, String data) async {
    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      return prefs.setString(key, data);
    } else {
      await _storage.write(
        key: key,
        value: data,
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
