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
    required DateTime dia,
    required this.horaInicio,
    required this.horaFin,
    required this.totalHoras,
    required this.actividad,
    required this.practica,
  }) : dia = dia.add(Duration(days: 1));

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

  factory SemanaActividad.fromJson(Map<String, dynamic> json) {
    return SemanaActividad(
      id: json['id'],
      dia: DateTime.parse(json['dia']),
      horaInicio: _parseTimeOfDay(json['horaInicio']),
      horaFin: _parseTimeOfDay(json['horaFin']),
      totalHoras: json['totalHoras'],
      actividad: json['actividad'],
      practica: Practica.fromJson(json['practica']),
    );
  }

  static TimeOfDay _parseTimeOfDay(String timeString) {
    final parts = timeString.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }
}
