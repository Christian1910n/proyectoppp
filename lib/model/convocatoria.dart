import 'package:proyectoppp/model/solicitudempresa .dart';
import 'package:proyectoppp/model/solicitudEstudiante.dart';
import 'package:proyectoppp/model/accionconvoca.dart';
import 'package:proyectoppp/model/practica.dart';

class Convocatoria {
  int id;
  DateTime fechaInicio;
  DateTime fechaFin;
  int numero;
  SolicitudEmpresa solicitudEmpresa;
  List<SolicitudEstudiante> solicitudEstudiantes;
  List<AccionConvoca> accionConvocas;
  List<Practica> practicas;

  Convocatoria({
    required this.id,
    required this.fechaInicio,
    required this.fechaFin,
    required this.numero,
    required this.solicitudEmpresa,
    required this.solicitudEstudiantes,
    required this.accionConvocas,
    required this.practicas,
  });
}
