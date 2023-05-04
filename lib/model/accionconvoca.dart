import 'package:proyectoppp/model/convocatoria.dart';
import 'package:proyectoppp/model/accion.dart';

class AccionConvoca {
  int id;
  bool respuesta;
  Accion accion;
  Convocatoria convocatoria;

  AccionConvoca({
    required this.id,
    required this.respuesta,
    required this.accion,
    required this.convocatoria,
  });
}
