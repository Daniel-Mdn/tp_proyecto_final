
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tp_proyecto_final/model/routine_model.dart';

class RoutineProvider extends ChangeNotifier {
  final Dio dio;
  RoutineProvider({required this.dio});

  Future<Routine> getRoutine(int id) async {
    final response = await dio.get('/rutina/get/$id');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      try {
        var routine = Routine.fromJson(response.data);

        return routine;
      } catch (e) {
        print('e in getRoutine $e');
        throw Exception('Failed to load routine');
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load routine');
    }
  }

  Future<List<Routine>> getRoutinesProfesionalUser([String? query]) async {
    final response = await dio.get('/rutina/getRutinasProfesional');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      try {
        var routineList = routineFromJson(response.data);

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
        print('e in getRoutinesProfesionalUser $e');
        return [];
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load exercises');
    }
  }

  Future<bool> createRoutine(Routine body) async {
    try {
      final response = await dio.post('/rutina/alta', data: body.toJson());
      if (response.statusCode == 200) {
        return true;
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
