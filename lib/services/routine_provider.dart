import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tp_proyecto_final/model/exercise_model.dart';
import 'package:tp_proyecto_final/model/routine_model.dart';

class RoutineProvider extends ChangeNotifier {
  Future<Routine> getRoutine() async {
    final response =
        await http.get(Uri.parse('./assets/mockup_data/users.json'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var usersList = Routine.fromJson(jsonDecode(response.body)[
          0]); //corregir cuando haya un endpoint que devuelva la info de un solo usuario
      return usersList;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load users');
    }
  }

  Future<List<Routine>> getRoutines([String? query]) async {
    final response =
        await http.get(Uri.parse('./assets/mockup_data/rutinas.json'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      try {
        var routineList = routineFromJson(response.body);
        print('routineList');
        print(routineList);

        if (query != null) {
          routineList = routineList
              .where((user) =>
                  user.name.toLowerCase().contains(query.toLowerCase()))
              .toList();
          print('routineList query');
          print(routineList);
        }
        return routineList;
      } catch (e) {
        return [];
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load exercises');
    }
  }
}
