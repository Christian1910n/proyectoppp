import 'package:proyectoppp/model/solicitudempresa .dart';

class Convocatoria {
  final int id;
  final DateTime fechaInicio;
  final DateTime fechaFin;
  final int numero;
  final SolicitudEmpresa solicitudEmpresa;

  Convocatoria(
      {required this.id,
      required String fechaInicio,
      required String fechaFin,
      required this.numero,
      required this.solicitudEmpresa})
      : fechaInicio = DateTime.parse(fechaInicio),
        fechaFin = DateTime.parse(fechaFin);

  factory Convocatoria.fromJson(Map<String, dynamic> json) {
    return Convocatoria(
      id: json['id'],
      fechaInicio: json['fechaInicio'],
      fechaFin: (json['fechaFin']),
      numero: (json['numero:']),
      solicitudEmpresa: SolicitudEmpresa.fromJson(json['solicitudEmpresa']),
    );
  }
}
