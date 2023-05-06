import 'package:proyectoppp/model/Carrera.dart';
import 'package:proyectoppp/model/Usuario.dart';

class Estudiante {
  int id;
  String periodo;
  String ciclo;
  int horasCumplidas;
  bool prioridad;
  int idEstudiante;
  Usuario usuario;
  Carrera carrera;

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
