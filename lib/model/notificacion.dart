import 'package:proyectoppp/model/Usuario.dart';

class Notificacion {
  final int id;
  final int tipo;
  final bool estado;
  final Usuario usuarioTutor;
  final Usuario usuarioEstudiante;

  Notificacion({
    required this.id,
    required this.tipo,
    required this.estado,
    required this.usuarioTutor,
    required this.usuarioEstudiante,
  });

  factory Notificacion.fromJson(Map<String, dynamic> json) {
    return Notificacion(
      id: json['id'],
      tipo: json['tipo'],
      estado: json['estado'],
      usuarioTutor: Usuario.fromJson(json['usuarioTutor']),
      usuarioEstudiante: Usuario.fromJson(json['usuarioEstudiante']),
    );
  }
}
