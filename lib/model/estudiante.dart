import 'package:proyectoppp/model/Carrera.dart';
import 'package:proyectoppp/model/Usuario.dart';

class Estudiante {
  final int id;
  final String periodo;
  final String ciclo;
  final int horasCumplidas;
  final bool prioridad;
  final int idEstudiante;
  final Usuario usuario;
  final Carrera carrera;

  Estudiante(
      {required this.id,
      required this.periodo,
      required this.ciclo,
      required this.horasCumplidas,
      required this.prioridad,
      required this.idEstudiante,
      required this.usuario,
      required this.carrera});
}
