import 'package:proyectoppp/model/convocatoria.dart';
import 'package:proyectoppp/model/estudiante.dart';
import 'package:proyectoppp/model/tutorInstituto.dart';
import 'package:proyectoppp/model/tutorEmpresarial.dart';

class Practica {
  final int id;
  final String periodo;
  final int nSemanas;
  final DateTime inicio;
  final DateTime fin;
  final String concluciones;
  final String departamento;
  final Convocatoria convocatoria;
  final Estudiante estudiante;
  final TutorInstituto tutorInstituto;
  final TutorEmpresarial tutorEmpresarial;

  Practica(
      {required this.id,
      required this.periodo,
      required this.nSemanas,
      required this.inicio,
      required this.fin,
      required this.concluciones,
      required this.departamento,
      required this.convocatoria,
      required this.estudiante,
      required this.tutorInstituto,
      required this.tutorEmpresarial});
}
