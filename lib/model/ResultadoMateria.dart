import 'package:proyectoppp/model/Carrera.dart';

class ResultadoMateria {
  final int id;
  final String descripcion;
  final Carrera carrera;

  ResultadoMateria(
      {required this.id, required this.descripcion, required this.carrera});
}
