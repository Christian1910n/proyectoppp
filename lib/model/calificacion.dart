import 'package:proyectoppp/model/practica.dart';

class Calificacion {
  final int id;
  final int tutor;
  final int a;
  final int b;
  final int c;
  final int d;
  final int e;
  final int total;
  final Practica practica;

  Calificacion({
    required this.id,
    required this.tutor,
    required this.a,
    required this.b,
    required this.c,
    required this.d,
    required this.e,
    required this.total,
    required this.practica,
  });
}
