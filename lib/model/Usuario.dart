import 'dart:convert';

class Usuario {
  int? id;
  String? cedula;
  String? nombre;
  String? apellido;
  String? correo;
  String? titulo;
  String? telefono;
  bool? activo;
  String? password;

  Usuario(
      {this.id,
      this.cedula,
      this.nombre,
      this.apellido,
      this.correo,
      this.titulo,
      this.telefono,
      this.activo,
      this.password});

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
        id: json['id'],
        cedula: (json['cedula']),
        apellido: utf8
            .decode(json['apellido'].toString().codeUnits)
            .replaceAll('?', 'ñ'),
        nombre: utf8
            .decode(json['nombre'].toString().codeUnits)
            .replaceAll('?', 'ñ'),
        correo: (json['correo']),
        titulo: (json['titulo']),
        telefono: (json['telefono']),
        activo: (json['activo']),
        password: json['password'] ?? '');
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'cedula': cedula,
        'nombre': nombre,
        'apellido': apellido,
        'correo': correo,
        'titulo': titulo,
        'telefono': telefono,
        'activo': activo,
        'password': password
      };
}
