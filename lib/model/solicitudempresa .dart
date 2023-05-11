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
}
