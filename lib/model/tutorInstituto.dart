import 'package:proyectoppp/model/Usuario.dart';

class TutorInstituto {
  int? id;
  int? idDocente;
  Usuario? usuario;

  TutorInstituto({this.id, this.idDocente, this.usuario});

  factory TutorInstituto.fromJson(Map<String, dynamic> json) {
    return TutorInstituto(
        id: json['id'],
        idDocente: json['idDocente'],
        usuario: Usuario.fromJson(json['usuario']));
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'idDocente': idDocente,
        'usuario': usuario,
      };
}
