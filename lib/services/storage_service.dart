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

  Future<String?> read(LocalStorageKeys key) async {
    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(key.name);
    } else {
      return await _storage.read(key: key.name);
    }
  }

  Future<bool> write(LocalStorageKeys key, String data) async {
    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      return prefs.setString(key.name, data);
    } else {
      await _storage.write(
        key: key.name,
        value: data,
      );
      return true;
    }
  }

  /// Cierra sesión eliminando el token
  Future<bool> delete(LocalStorageKeys key) async {
    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      return prefs.remove(key.name);
    } else {
      await _storage.delete(key: key.name);
      return true;
    }
  }
}

enum LocalStorageKeys { jwtToken, user }
