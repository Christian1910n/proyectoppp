import 'package:proyectoppp/model/practica.dart';

class Visita {
  final int id;
  final String asunto;
  final int semana;
  final String observacion;
  final Practica practica;

  Visita(
      {required this.id,
      required this.asunto,
      required this.semana,
      required this.observacion,
      required this.practica});
}
