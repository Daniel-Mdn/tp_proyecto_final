import 'dart:convert';

List<UserModel> userModelFromJson(List<dynamic> list) {
  return List<UserModel>.from(list.map((x) {
    return UserModel.fromJson(x);
  }));
}

String userModelToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  UserModel({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.email,
    required this.sexo,
    required this.fechaNacimiento,
    required this.telefono,
    required this.role,
    this.password,
  });

  final int id;
  final String nombre;
  final String apellido;
  final String email;
  final Genero sexo;
  final DateTime fechaNacimiento;
  final int telefono;
  final TipoUsuario role;
  final String? password;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"] ?? 0,
      nombre: json["nombre"],
      apellido: json["apellido"],
      email: json["username"],
      sexo: json["sexo"] == 'femenino' ? Genero.femenino : Genero.masculino,
      fechaNacimiento: json["fecha_nacimiento"] is String
          ? DateTime.parse(json["fecha_nacimiento"])
          : json["fecha_nacimiento"],
      telefono: json["telefono"],
      role: TipoUsuario.values.firstWhere(
          (val) => val.name == json["role"],
          orElse: () => TipoUsuario.cliente),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "nombre": nombre,
      "apellido": apellido,
      "username": email,
      "sexo": sexo.name,
      "fecha_nacimiento": fechaNacimiento.toIso8601String().split('T').first,
      "telefono": telefono,
      "role": role.name,
    };
  }
}

enum Genero { masculino, femenino }

enum TipoUsuario { cliente, profesional }
