import 'package:proyectoppp/model/Usuario.dart';
import 'package:proyectoppp/model/empresa.dart';

class TutorEmpresarial {
  final int id;
  final String cargo;
  final Empresa empresa;
  final Usuario usuario;

  TutorEmpresarial(
      {required this.id,
      required this.cargo,
      required this.empresa,
      required this.usuario});

  factory TutorEmpresarial.fromJson(Map<String, dynamic> json) {
    return TutorEmpresarial(
      id: json['id'],
      cargo: json['cargo'],
      empresa: Empresa.fromJson(json['empresa']),
      usuario: Usuario.fromJson(json['usuario']),
    );
  }

  Map<String, dynamic> toJson()=> {
      'id': id,
      'cargo': cargo,
      'empresa': empresa.toJson(),
      'usuario': usuario.toJson(),
  };
}
