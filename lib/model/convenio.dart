import 'package:proyectoppp/model/Carrera.dart';
import 'package:proyectoppp/model/empresa.dart';
import 'package:proyectoppp/model/tutorInstituto.dart';

class Convenio {
  int? id;
  int? numero;
  DateTime? fechaInicio;
  DateTime? fechaFin;
  Empresa? empresa;
  Carrera? carrera;
  TutorInstituto? firmaInst;

  Convenio(
      {this.id,
      this.numero,
      this.fechaFin,
      this.fechaInicio,
      this.empresa,
      this.carrera,
      this.firmaInst});

  factory Convenio.fromJson(Map<String, dynamic> json) {
    return Convenio(
      id: json['id'],
      numero: json['numero'],
      fechaInicio: DateTime.parse(json['fechaInicio']),
      fechaFin: DateTime.parse(json['fechaFin']),
      empresa: Empresa.fromJson(json['empresa']),
      carrera: Carrera.fromJson(json['carrera']),
      firmaInst: TutorInstituto.fromJson(json['firmaInst']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'numero': numero,
      'fechaInicio': fechaInicio?.toIso8601String(),
      'fechaFin': fechaFin?.toIso8601String(),
      'empresa': empresa?.toJson(),
      'carrera': carrera?.toJson(),
      'firmaInst': firmaInst?.toJson(),
    };
  }
}
