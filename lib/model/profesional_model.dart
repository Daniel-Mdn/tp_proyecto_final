import 'dart:convert';

import 'package:tp_proyecto_final/model/user_model.dart';

List<ProfesionalModel> userModelFromJson(String str) =>
    List<ProfesionalModel>.from((json.decode(str) as List<dynamic>).map((x) {
      return ProfesionalModel.fromJson(x);
    }));

String userModelToJson(List<ProfesionalModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProfesionalModel {
  ProfesionalModel({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.email,
    required this.genero,
    required this.fechaNacimiento,
    required this.telefono,
    required this.rol,
  });

  final int id;
  final String nombre;
  final String apellido;
  final String email;
  final Genero genero;
  final DateTime fechaNacimiento;
  final String telefono;
  final TipoUsuario rol;

  factory ProfesionalModel.fromJson(Map<String, dynamic> json) {
    return ProfesionalModel(
      id: json["id"],
      nombre: json["nombre"],
      apellido: json["apellido"],
      email: json["email"],
      genero: json["genero"] == 'femenino' ? Genero.femenino : Genero.masculino,
      fechaNacimiento: json["fecha_nacimiento"] is String
          ? DateTime.parse(json["fecha_nacimiento"])
          : json["fecha_nacimiento"],
      telefono: json["telefono"],
      rol: TipoUsuario.values
          .firstWhere((val) => val.toString() == json["rol"], orElse: () => TipoUsuario.cliente),
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "apellido": apellido,
        "email": email,
        "genero": genero,
        "fechaNacimiento": fechaNacimiento,
        "telefono": telefono,
        "rol": rol,
      };
}

enum Genero { masculino, femenino }

enum TipoProfesional { entrenador, nutricionista }
