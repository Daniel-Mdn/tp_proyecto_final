import 'dart:convert';

class Exercise {
  int id;
  String name;
  String description;
  String muscleGroup;

  Exercise({
    required this.id,
    required this.name,
    required this.description,
    required this.muscleGroup,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json["id"],
      name: json["nombre"],
      description: json["descripcion"],
      muscleGroup: json["grupo_musculares"],
    );
  }

  Map<String, dynamic> toJson() => {
        'id_ejercicio': id,
        'nombre': name,
        'descripcion': description,
        'grupo_musculares': muscleGroup,
      };
}

List<Exercise> exerciseFromJson(String str) =>
    List<Exercise>.from((json.decode(str) as List<dynamic>).map((x) {
      return Exercise.fromJson(x);
    }));

class ExerciseDay {
  int? id;
  int exerciseId;
  String? observations;
  int sets;
  int repetitions;
  double weight;

  Exercise exerciseData;

  ExerciseDay({
    this.id,
    required this.exerciseId,
    required this.sets,
    required this.repetitions,
    required this.weight,
    required this.exerciseData,
    this.observations,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'id_ejercicio': exerciseId,
        'observaciones': observations,
        'series': sets,
        'repeticiones': repetitions,
        'peso': weight,
      };
}
