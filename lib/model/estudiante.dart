import 'package:proyectoppp/model/Carrera.dart';
import 'package:proyectoppp/model/Usuario.dart';

class Estudiante {
  int id;
  String periodo;
  int ciclo;
  int horasCumplidas;
  bool prioridad;
  int idEstudiante;
  Usuario usuario;
  Carrera carrera;

  Estudiante(
      {required this.id,
      required this.periodo,
      required this.ciclo,
      required this.horasCumplidas,
      required this.prioridad,
      required this.idEstudiante,
      required this.usuario,
      required this.carrera});

  factory Estudiante.fromJson(Map<String, dynamic> json) {
    return Estudiante(
        id: json['id'],
        periodo: json['periodo'],
        ciclo: (json['ciclo']),
        horasCumplidas: (json['horasCumplidas']),
        prioridad: json['prioridad'],
        idEstudiante: json['idEstudiante'],
        usuario: Usuario.fromJson(json['usuario']),
        carrera: Carrera.fromJson(json['carrera']));
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'periodo': periodo,
        'ciclo': ciclo,
        'horasCumplidas': horasCumplidas,
        'prioridad': prioridad,
        'idEstudiante': idEstudiante,
        'usuario': usuario,
        'carrera': carrera
      };
}
