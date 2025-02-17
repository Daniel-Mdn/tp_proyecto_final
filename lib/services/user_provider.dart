import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tp_proyecto_final/model/user_model.dart';

class UserProvider {
  Future<UserModel> getUser() async {
    final response = await http.get(Uri.parse('./mockup_data/users.json'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var usersList = UserModel.fromJson(jsonDecode(response.body)[0]); //corregir cuando haya un endpoint que devuelva la info de un solo usuario
      return usersList;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load users');
    }
  }

  Future<List<UserModel>> getUsers() async {
    final response = await http.get(Uri.parse('./mockup_data/users.json'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      try {
        var usersList = userModelFromJson(response.body);
        return usersList;
      } catch (e) {
        return [];
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load users');
    }
  }

  Future<List<UserModel>> getProfesionals() async {
    final response = await http.get(Uri.parse('./mockup_data/profesionales.json'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      try {
        var usersList = userModelFromJson(response.body);
        return usersList;
      } catch (e) {
        return [];
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load users');
    }
  }
}
