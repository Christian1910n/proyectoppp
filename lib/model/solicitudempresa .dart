import 'package:proyectoppp/model/convenio.dart';

class SolicitudEmpresa {
  final int id;
  final int numPracticantes;
  final int numHoras;
  final DateTime fechaInicioTen;
  final DateTime fechaMaxTen;
  final int estado;
  final Convenio convenio;

  SolicitudEmpresa(
      {required this.id,
      required this.numPracticantes,
      required this.numHoras,
      required this.fechaInicioTen,
      required this.fechaMaxTen,
      required this.estado,
      required this.convenio});

  factory SolicitudEmpresa.fromJson(Map<String, dynamic> json) {
    return SolicitudEmpresa(
        id: json['id'],
        numPracticantes: json['numPracticantes'],
        numHoras: json['numHoras'],
        fechaInicioTen: DateTime.parse(json['fechaInicioTen:']),
        fechaMaxTen: DateTime(json['fechaMaxTen']),
        estado: json['estado'],
        convenio: json['convenio']);
  }
}
