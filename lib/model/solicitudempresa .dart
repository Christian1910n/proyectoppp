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
      required String fechaInicioTen,
      required String fechaMaxTen,
      required this.estado,
      required this.convenio})
      : fechaInicioTen = DateTime.parse(fechaInicioTen),
        fechaMaxTen = DateTime.parse(fechaMaxTen);
}
