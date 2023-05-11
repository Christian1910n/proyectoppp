import 'package:proyectoppp/model/Carrera.dart';

class Materia {
  final int id;
  final int idMateria;
  final String nombre;
  final Carrera carrera;

  Materia(
      {required this.id,
      required this.idMateria,
      required this.nombre,
      required this.carrera});

  factory Materia.fromJson(Map<String, dynamic> json) {
    return Materia(
      id: json['id'],
      idMateria: json['idMateria'],
      nombre: json['nombre'],
      carrera: Carrera.fromJson(json['solicitudEmpresa']),
    );
  }
}
