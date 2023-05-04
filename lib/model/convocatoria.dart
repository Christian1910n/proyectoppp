import 'package:proyectoppp/model/solicitudempresa .dart';

class Convocatoria {
  final int id;
  final DateTime fechaInicio;
  final DateTime fechaFin;
  final int numero;
  final SolicitudEmpresa solicitudEmpresa;

  Convocatoria(
      {required this.id,
      required this.fechaInicio,
      required this.fechaFin,
      required this.numero,
      required this.solicitudEmpresa});
}
