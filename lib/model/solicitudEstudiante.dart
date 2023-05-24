import 'package:proyectoppp/model/estudiante.dart';
import 'package:proyectoppp/model/convocatoria.dart';

class SolicitudEstudiante {
  final int id;
  int estado;
  final DateTime fechaEnvio;
  final Estudiante estudiante;
  final Convocatoria convocatoria;

  SolicitudEstudiante(
      {required this.id,
      required this.estado,
      required this.fechaEnvio,
      required this.estudiante,
      required this.convocatoria});

  factory SolicitudEstudiante.fromJson(Map<String, dynamic> json) {
    return SolicitudEstudiante(
        id: json['id'],
        estado: json['estado'],
        fechaEnvio: DateTime.parse(json['fechaEnvio']),
        estudiante: Estudiante.fromJson(json['estudiante']),
        convocatoria: Convocatoria.fromJson(json['convocatoria']));
  }
}
