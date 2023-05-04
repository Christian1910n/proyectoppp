import 'package:proyectoppp/model/aspecto.dart';
import 'package:proyectoppp/model/practica.dart';

class AspectoPractica {
  final int id;
  final bool respuesta;
  final Aspecto aspecto;
  final Practica practica;

  AspectoPractica(
      {required this.id,
      required this.respuesta,
      required this.aspecto,
      required this.practica});
}
