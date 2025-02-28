
import 'package:tp_proyecto_final/model/exercise_model.dart';

class Routine {
  String name;
  String objective;
  int duration;
  String difficulty;
  String description;
  List<RoutineDay> days;

  Routine({
    required this.name,
    required this.objective,
    required this.duration,
    required this.difficulty,
    required this.description,
    required this.days,
  });

  Map<String, dynamic> toJson() => {
        'nombre': name,
        'objetivo': objective,
        'duracion': duration,
        'dificultad': difficulty,
        'descripcion': description,
        'esquema': days.map((day) => day.toJson()).toList(),
      };
}

class RoutineDay {
  int order;
  String day;
  String observations;
  List<ExerciseDay> exercises;

  RoutineDay({
    required this.order,
    required this.day,
    required this.observations,
    required this.exercises,
  });

  Map<String, dynamic> toJson() => {
        'orden': order,
        'dia': day,
        'observaciones': observations,
        'ejercicios': exercises.map((exercise) => exercise.toJson()).toList(),
      };
}


