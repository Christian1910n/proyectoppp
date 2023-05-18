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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dia': dia.toIso8601String(),
      'horaInicio':
          '${horaInicio.hour.toString().padLeft(2, '0')}:${horaInicio.minute.toString().padLeft(2, '0')}:00',
      'horaFin':
          '${horaFin.hour.toString().padLeft(2, '0')}:${horaFin.minute.toString().padLeft(2, '0')}:00',
      'totalHoras': totalHoras,
      'actividad': actividad,
      'practica': practica.toJson(),
    };
  }
}
