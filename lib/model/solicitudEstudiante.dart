import 'package:proyectoppp/model/estudiante.dart';
import 'package:proyectoppp/model/convocatoria.dart';

 class SolicitudEstudiante {

  int id;
  bool estado;
  late DateTime fechaEnvio;
  Estudiante estudiante;
  Convocatoria convocatoria;

  SolicitudEstudiante({
    required this.id,
    required this.estado,
    required this.estudiante,
    required this.convocatoria
  });

}
