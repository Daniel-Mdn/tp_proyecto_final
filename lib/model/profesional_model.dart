import 'dart:convert';

import 'package:tp_proyecto_final/model/user_model.dart';

List<ProfesionalModel> profesionalModelFromJson(String str) =>
    List<ProfesionalModel>.from((json.decode(str) as List<dynamic>).map((x) {
      return ProfesionalModel.fromJson(x);
    }));

String profesionalModelToJson(List<ProfesionalModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProfesionalModel extends UserModel {
  ProfesionalModel(
      {required super.id,
      required super.nombre,
      required super.apellido,
      required super.email,
      required super.sexo,
      required super.fechaNacimiento,
      required super.telefono,
      required super.role,
      required this.specialty,
      required this.sportsTag,
      super.password});

  final TipoProfesional specialty;
  final String sportsTag;

  factory ProfesionalModel.fromJson(Map<String, dynamic> json) {
    return ProfesionalModel(
        id: json["id"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        email: json["username"],
        sexo: json["sexo"] == 'femenino' ? Genero.femenino : Genero.masculino,
        fechaNacimiento: json["fecha_nacimiento"] is String
            ? DateTime.parse(json["fecha_nacimiento"])
            : json["fecha_nacimiento"],
        telefono: json["telefono"],
        role: TipoUsuario.values.firstWhere(
            (val) => val.toString() == json["role"],
            orElse: () => TipoUsuario.cliente),
        specialty: json['especialidad'],
        sportsTag: json['deporte_tag']);
  }

  @override
  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "apellido": apellido,
        "username": email,
        "sexo": sexo.name,
        "fecha_nacimiento": fechaNacimiento.toIso8601String().split('T').first,
        "telefono": telefono,
        "role": role.name,
        "password": password,
        "especialidad": specialty.name,
        "deporte_tag": sportsTag,
      };
}

enum TipoProfesional { entrenador, nutricionista }
