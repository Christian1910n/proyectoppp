
import 'package:proyectoppp/model/convocatoria.dart';
import 'package:proyectoppp/model/convenio.dart';
import 'package:proyectoppp/model/actividad.dart';
class SolicitudEmpresa {
  int id;
  int numPracticantes;
  int numHoras;
  DateTime fechaInicioTen;
  DateTime fechaMaxTen;
  int estado;
  Convenio convenio;
  List<Actividad> actividades;
  List<Convocatoria> convocatorias;

  SolicitudEmpresa({
    required this.id,
    required this.numPracticantes,
    required this.numHoras,
    required this.fechaInicioTen,
    required this.fechaMaxTen,
    required this.estado,
    required this.convenio,
    required this.actividades,
    required this.convocatorias,
  });
}