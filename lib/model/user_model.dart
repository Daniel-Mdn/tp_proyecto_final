import 'dart:convert';

List<UserModel> userModelFromJson(String str) =>
    List<UserModel>.from((json.decode(str) as List<dynamic>).map((x) {
      return UserModel.fromJson(x);
    }));

String userModelToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  UserModel({
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
  final int telefono;
  final TipoUsuario rol;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      nombre: json["nombre"],
      apellido: json["apellido"],
      email: json["username"],
      genero: json["sexo"] == 'femenino' ? Genero.femenino : Genero.masculino,
      fechaNacimiento: json["fecha_nacimiento"] is String
          ? DateTime.parse(json["fecha_nacimiento"])
          : json["fecha_nacimiento"],
      telefono: json["telefono"],
      rol: TipoUsuario.values
          .firstWhere((val) => val.toString() == json["role"], orElse: () => TipoUsuario.cliente),
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

enum TipoUsuario { cliente, profesional }
