import 'package:proyectoppp/model/Carrera.dart';
import 'package:proyectoppp/model/empresa.dart';
import 'package:proyectoppp/model/tutorInstituto.dart';

class Convenio {
  final int id;
  final int numero;
  final DateTime fechaInicio;
  final DateTime fechaFin;
  final Empresa empresa;
  final Carrera carrera;
  final TutorInstituto firmaInst;

  Convenio(
      {required this.id,
      required this.numero,
      required String fechaFin,
      required String fechaInicio,
      required this.empresa,
      required this.carrera,
      required this.firmaInst})
      : fechaFin = DateTime.parse(fechaFin),
        fechaInicio = DateTime.parse(fechaInicio);

  factory Convenio.fromJson(Map<String, dynamic> json) {
    return Convenio(
      id: json['id'],
      numero: json['numero'],
      fechaInicio: (json['fechaInicio']),
      fechaFin: (json['fechaFin']),
      empresa: Empresa.fromJson(json['empresa']),
      carrera: Carrera.fromJson(json['carrera']),
      firmaInst: TutorInstituto.fromJson(json['firmaInst']),
    );
  }
}
