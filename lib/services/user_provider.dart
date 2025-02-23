import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tp_proyecto_final/model/user_model.dart';

class UserProvider extends ChangeNotifier {
  Future<UserModel> getUser() async {
    final response =
        await http.get(Uri.parse('./assets/mockup_data/users.json'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var usersList = UserModel.fromJson(jsonDecode(response.body)[
          0]); //corregir cuando haya un endpoint que devuelva la info de un solo usuario
      return usersList;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load users');
    }
  }

  Future<List<UserModel>> getUsers([String? query]) async {
    final response =
        await http.get(Uri.parse('./assets/mockup_data/users.json'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      try {
        var usersList = userModelFromJson(response.body);
        print('usersList');
        print(usersList);

        if (query != null) {
          usersList =
              usersList.where((user) => user.nombre.toLowerCase().contains(query.toLowerCase())).toList();
          print('usersList query');
          print(usersList);
        }
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
    final response =
        await http.get(Uri.parse('./assets/mockup_data/profesionales.json'));
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
