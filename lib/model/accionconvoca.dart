import 'package:proyectoppp/model/convocatoria.dart';
import 'package:proyectoppp/model/accion.dart';

class AccionConvoca {
  final int id;
  final bool respuesta;
  final Accion accion;
  final Convocatoria convocatoria;

  AccionConvoca({
    required this.id,
    required this.respuesta,
    required this.accion,
    required this.convocatoria,
  });
}
