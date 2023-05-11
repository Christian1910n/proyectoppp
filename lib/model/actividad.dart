import 'package:proyectoppp/model/Materia.dart';
import 'package:proyectoppp/model/solicitudempresa%20.dart';

class Actividad {
  final int id;
  final String descripcion;
  final SolicitudEmpresa solicitudEmpresa;
  final Materia materia;

  Actividad(
      {required this.id,
      required this.descripcion,
      required this.solicitudEmpresa,
      required this.materia});

  factory Actividad.fromJson(Map<String, dynamic> json) {
    return Actividad(
      id: json['id'],
      descripcion: json['descripcion'],
      solicitudEmpresa: SolicitudEmpresa.fromJson(json['solicitudEmpresa']),
      materia: Materia.fromJson(json['materia']),
    );
  }
}
