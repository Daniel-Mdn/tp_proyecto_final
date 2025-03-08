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
      muscleGroup: json["grupo_muscular"],
    );
  }

  Map<String, dynamic> toJson() => {
        'id_ejercicio': id,
        'nombre': name,
        'descripcion': description,
        'grupo_musculares': muscleGroup,
      };
}

List<Exercise> exerciseFromJson(List<dynamic> list) {
  return List<Exercise>.from(list.map((x) {
    return Exercise.fromJson(x);
  }));
}

class ExerciseDay {
  int? id;
  int exerciseId;
  String? exerciseName;
  String? observations;
  int sets;
  int repetitions;
  double weight;

  Exercise? exerciseData;

  ExerciseDay({
    this.id,
    required this.exerciseId,
    required this.sets,
    required this.repetitions,
    required this.weight,
    this.exerciseData,
    this.exerciseName,
    this.observations,
  });

  factory ExerciseDay.fromJson(Map<String, dynamic> json) {
    return ExerciseDay(
      id: json["id"],
      exerciseId: json["id_ejercicio"],
      sets: json["series"],
      repetitions: json["repeticiones"],
      weight: json["peso"],
      exerciseName: json["nombre_ejercicio"],
      observations: json["observations"],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'id_ejercicio': exerciseId,
        "nombre_ejercicio": exerciseName,
        'observaciones': observations,
        'series': sets,
        'repeticiones': repetitions,
        'peso': weight,
      };
}

List<ExerciseDay> exerciseDayFromJson(List<dynamic> list) {
  return List<ExerciseDay>.from(list.map((x) {
    return ExerciseDay.fromJson(x);
  }));
}
