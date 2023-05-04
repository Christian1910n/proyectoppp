import 'package:proyectoppp/model/estudiante.dart';
import 'package:proyectoppp/model/convocatoria.dart';

class SolicitudEstudiante {
  final int id;
  final bool estado;
  final DateTime fechaEnvio;
  final Estudiante estudiante;
  final Convocatoria convocatoria;

  SolicitudEstudiante(
      {required this.id,
      required this.estado,
      required this.fechaEnvio,
      required this.estudiante,
      required this.convocatoria});
}
