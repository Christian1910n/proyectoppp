import 'dart:convert';

class UsuarioFenix {
  final int alumno_docenteId;
  final String cedula;
  final String nombres;
  final String apellidos;
  final String correo;
  final String telefono;
  final String titulo;
  final int ciclo;
  final int carreraId;
  final String periodo;
  final int tipo;

  UsuarioFenix(
      {required this.alumno_docenteId,
      required this.cedula,
      required this.apellidos,
      required this.nombres,
      required this.carreraId,
      required this.ciclo,
      required this.correo,
      required this.periodo,
      required this.telefono,
      required this.tipo,
      required this.titulo});

  factory UsuarioFenix.fromJson(Map<String, dynamic> json) {
    return UsuarioFenix(
      alumno_docenteId: json['alumno_docenteId'] ?? 0,
      cedula: json['cedula'] ?? '',
      apellidos: utf8
          .decode(json['apellidos'].toString().codeUnits)
          .replaceAll('?', 'ñ'),
      nombres: utf8
          .decode(json['nombres'].toString().codeUnits)
          .replaceAll('?', 'ñ'),
      carreraId: json['carreraId'] ?? 0,
      ciclo: json['ciclo'] ?? 0,
      correo: json['correo'] ?? '',
      telefono: json['telefono'] ?? '',
      tipo: json['tipo'] ?? 0,
      titulo: json['titulo'] ?? '',
      periodo: json['periodo'] ?? '',
    );
  }
}
