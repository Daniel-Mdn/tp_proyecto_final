import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tp_proyecto_final/model/exercise_model.dart';

class ExerciseProvider extends ChangeNotifier {
  Future<Exercise> getExercise() async {
    final response =
        await http.get(Uri.parse('./assets/mockup_data/users.json'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var usersList = Exercise.fromJson(jsonDecode(response.body)[
          0]); //corregir cuando haya un endpoint que devuelva la info de un solo usuario
      return usersList;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load users');
    }
  }

  Future<List<Exercise>> getExercises([String? query]) async {
    final response =
        await http.get(Uri.parse('./assets/mockup_data/ejercicios.json'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      try {
        var exerciseList = exerciseFromJson(response.body);
        print('exerciseList');
        print(exerciseList);

        if (query != null) {
          exerciseList = exerciseList
              .where((user) =>
                  user.name.toLowerCase().contains(query.toLowerCase()))
              .toList();
          print('exerciseList query');
          print(exerciseList);
        }
        return exerciseList;
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
