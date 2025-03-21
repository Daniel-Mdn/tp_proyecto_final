import 'package:tp_proyecto_final/model/exercise_model.dart';

class Routine {
  int? id;
  String name;
  String objective;
  int duration;
  String difficulty;
  String description;
  List<RoutineDay> days;

  Routine({
    this.id,
    required this.name,
    required this.objective,
    required this.duration,
    required this.difficulty,
    required this.description,
    required this.days,
  });

  factory Routine.fromJson(Map<String, dynamic> json) {
    return Routine(
      id: json["id"],
      name: json["nombre"],
      objective: json["objetivo"],
      duration: json["duracion"],
      difficulty: json["dificultad"],
      description: json["descripcion"],
      days: routineDayFromJson(json["esquema"] ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
        'nombre': name,
        'objetivo': objective,
        'duracion': duration,
        'dificultad': difficulty,
        'descripcion': description,
        'esquema': days.map((day) => day.toJson()).toList(),
      };
}

List<Routine> routineFromJson(List<dynamic> list) {
  return List<Routine>.from(list.map((x) {
    return Routine.fromJson(x);
  }));
}

List<RoutineDay> routineDayFromJson(List<dynamic> list) {
  return List<RoutineDay>.from(list.map((x) {
    return RoutineDay.fromJson(x);
  }));
}

class RoutineDay {
  int? id;
  int order;
  String day;
  String observations;
  List<ExerciseDay> exercises;

  RoutineDay({
    required this.order,
    required this.day,
    required this.observations,
    required this.exercises,
    this.id,
  });

  factory RoutineDay.fromJson(Map<String, dynamic> json) {
    return RoutineDay(
      id: json["id"],
      observations: json["observaciones"],
      day: json["dia"] ?? "",
      order: json["orden"],
      exercises: exerciseDayFromJson(json["ejercicios"] ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
        'orden': order,
        'dia': day,
        'observaciones': observations,
        'ejercicios': exercises.map((exercise) => exercise.toJson()).toList(),
      };
}
