import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tp_proyecto_final/model/user_model.dart';

class UserProvider extends ChangeNotifier {
  final Dio dio;

  UserProvider({required this.dio});

  Future<UserModel> getUser(int id) async {
    final response = await dio.get('/usuario/get/$id');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var usersList = UserModel.fromJson(jsonDecode(response.data)[
          0]); //corregir cuando haya un endpoint que devuelva la info de un solo usuario
      return usersList;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load users');
    }
  }

  Future<List<UserModel>> getUsers([String? query]) async {
    final response = await dio.get<List<dynamic>>('/usuario/getAll');
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      if (response.data == null || response.data!.isEmpty) {
        return [];
      }
      try {
        var usersList = userModelFromJson(response.data!);

        if (query != null) {
          usersList = usersList
              .where((user) =>
                  user.nombre.toLowerCase().contains(query.toLowerCase()))
              .toList();
        }
        return usersList;
      } catch (e) {
        print('e in getUsers $e');
        return [];
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load users');
    }
  }

  Future<List<UserModel>> getProfesionals() async {
    final response = await dio.get<List<dynamic>>('/usuario/getAll');
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      try {
        var usersList = userModelFromJson(response.data!);
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
