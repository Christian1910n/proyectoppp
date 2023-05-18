import 'package:proyectoppp/model/convenio.dart';

class SolicitudEmpresa {
  int? id;
  int? numPracticantes;
  int? numHoras;
  DateTime? fechaInicioTen;
  DateTime? fechaMaxTen;
  int? estado;
  Convenio? convenio;

  SolicitudEmpresa({
    this.id,
    this.numPracticantes,
    this.numHoras,
    this.fechaInicioTen,
    this.fechaMaxTen,
    this.estado,
    this.convenio,
  });

  factory SolicitudEmpresa.fromJson(Map<String, dynamic> json) {
    return SolicitudEmpresa(
      id: json['id'],
      numPracticantes: json['numPracticantes'],
      numHoras: json['numHoras'],
      fechaInicioTen: DateTime.parse(json['fechaInicioTen']),
      fechaMaxTen: DateTime.parse(json['fechaMaxTen']),
      estado: json['estado'],
      convenio: Convenio.fromJson(json['convenio']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'numPracticantes': numPracticantes,
      'numHoras': numHoras,
      'fechaInicioTen': fechaInicioTen?.toIso8601String(),
      'fechaMaxTen': fechaMaxTen?.toIso8601String(),
      'estado': estado,
      'convenio': convenio?.toJson(),
    };
  }
}
