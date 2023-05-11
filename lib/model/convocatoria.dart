import 'package:proyectoppp/model/solicitudempresa .dart';

class Convocatoria {
  int? id;
  DateTime? fechaInicio;
  DateTime? fechaFin;
  int? numero;
  SolicitudEmpresa? solicitudEmpresa;

  Convocatoria(
      {this.id,
      this.fechaInicio,
      this.fechaFin,
      this.numero,
      this.solicitudEmpresa});

  factory Convocatoria.fromJson(Map<String, dynamic> json) {
    return Convocatoria(
      id: json['id'],
      fechaInicio: DateTime.parse(json['fechaInicio']),
      fechaFin: DateTime.parse(json['fechaFin']),
      numero: (json['numero:']),
      solicitudEmpresa: SolicitudEmpresa.fromJson(json['solicitudEmpresa']),
    );
  }
}
