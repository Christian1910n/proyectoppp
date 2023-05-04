import 'package:proyectoppp/model/aspectoPractica.dart';
import 'package:proyectoppp/model/calificacion.dart';
import 'package:proyectoppp/model/convocatoria.dart';
import 'package:proyectoppp/model/estudiante.dart';
import 'package:proyectoppp/model/resultado.dart';
import 'package:proyectoppp/model/semanaActividad.dart';
import 'package:proyectoppp/model/tutorInstituto.dart';
import 'package:proyectoppp/model/tutorEmpresarial.dart';
import 'package:proyectoppp/model/anexos.dart';
import 'package:proyectoppp/model/visita.dart';

class Practica {
  int id;
  String periodo;
  int nSemanas;
  DateTime inicio;
  DateTime fin;
  String concluciones;
  String departamento;


  Convocatoria convocatoria;
  Estudiante estudiante;
  TutorInstituto tutorInstituto;
  TutorEmpresarial tutorEmpresarial;


  List<Anexos> anexos;
  List<Resultado> resultados;
  List<SemanaActividad> semanasActividades;
  List<Calificacion> calificaciones;
  List<Visita> visitas;
  List<AspectoPractica> aspectos;

  Practica({
    required this.id,
    required this.periodo,
    required this.nSemanas,
    required this.inicio,
    required this.fin,
    required this.concluciones,
    required this.departamento,
    required this.convocatoria,
    required this.estudiante,
    required this.tutorInstituto,
    required this.tutorEmpresarial,
    required this.anexos,
    required this.resultados,
    required this.semanasActividades,
    required this.calificaciones,
    required this.visitas,
    required this.aspectos,
  });
}
