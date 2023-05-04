import 'package:proyectoppp/model/ResultadoMateria.dart';
import 'package:proyectoppp/model/practica.dart';

class Resultado {
  final int id;
  final Practica practica;
  final ResultadoMateria resultadoMateria;

  Resultado(
      {required this.id,
      required this.practica,
      required this.resultadoMateria});
}
