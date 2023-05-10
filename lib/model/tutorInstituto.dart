import 'package:proyectoppp/model/Usuario.dart';

class TutorInstituto {
  final int id;
  final String idDocente;
  final Usuario usuario;

  TutorInstituto(
      {required this.id, required this.idDocente, required this.usuario});

  factory TutorInstituto.fromJson(Map<String, dynamic> json) {
    return TutorInstituto(
        id: json['id'],
        idDocente: json['idDocente'],
        usuario: Usuario.fromJson(json['usuario']));
  }
}
