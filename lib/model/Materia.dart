import 'package:proyectoppp/model/Carrera.dart';

class Materia {
  final int id;
  final int idMateria;
  final String nombre;
  final Carrera carrera;

  Materia(
      {required this.id,
      required this.idMateria,
      required this.nombre,
      required this.carrera});
}
