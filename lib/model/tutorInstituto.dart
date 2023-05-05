import 'package:proyectoppp/model/Usuario.dart';

class TutorInstituto {
  final int id;
  final String idDocente;
  final int rol;
  final Usuario usuario;

  TutorInstituto(
      {required this.id,
      required this.idDocente,
      required this.rol,
      required this.usuario});

  factory TutorInstituto.fromJson(Map<String, dynamic> json) {
    return TutorInstituto(
        id: json['id'],
        idDocente: json['idDocente'],
        rol: (json['rol']),
        usuario: Usuario.fromJson(json['usuario']));
  }
}
