import 'package:proyectoppp/model/convocatoria.dart';
import 'package:proyectoppp/model/estudiante.dart';
import 'package:proyectoppp/model/tutorInstituto.dart';
import 'package:proyectoppp/model/tutorEmpresarial.dart';

class Practica {
  final int id;
  final String periodo;
  final int nSemanas;
  final DateTime inicio;
  final DateTime fin;
  final String concluciones;
  final String departamento;
  final int estado;
  final Convocatoria convocatoria;
  final Estudiante estudiante;
  final TutorInstituto tutorInstituto;
  final TutorEmpresarial tutorEmpresarial;

  Practica(
      {required this.id,
      required this.periodo,
      required this.nSemanas,
      required this.inicio,
      required this.fin,
      required this.concluciones,
      required this.departamento,
      required this.estado,
      required this.convocatoria,
      required this.estudiante,
      required this.tutorInstituto,
      required this.tutorEmpresarial});

  factory Practica.fromJson(Map<String, dynamic> json) {
    return Practica(
      id: json['id'],
      periodo: json['periodo'],
      nSemanas: json['nsemanas'],
      inicio: DateTime.parse(json['inicio']),
      fin: DateTime.parse(json['fin']),
      concluciones: json['concluciones'],
      departamento: json['departamento'],
      estado: json['estado'],
      convocatoria: Convocatoria.fromJson(json['convocatoria']),
      estudiante: Estudiante.fromJson(json['estudiante']),
      tutorInstituto: TutorInstituto.fromJson(json['tutorInstituto']),
      tutorEmpresarial: TutorEmpresarial.fromJson(json['tutorEmpresarial']),
    );
  }
}
