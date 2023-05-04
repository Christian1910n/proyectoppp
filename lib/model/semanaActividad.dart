import 'package:flutter/material.dart';
import 'package:proyectoppp/model/practica.dart';

class SemanaActividad {
  final int id;
  final DateTime dia;
  final TimeOfDay horaInicio;
  final TimeOfDay horaFin;
  final int totalHoras;
  final String actividad;
  final Practica practica;

  SemanaActividad({
    required this.id,
    required this.dia,
    required this.horaInicio,
    required this.horaFin,
    required this.totalHoras,
    required this.actividad,
    required this.practica,
  });
}
