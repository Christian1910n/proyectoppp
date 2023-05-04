import 'package:proyectoppp/model/Usuario.dart';
import 'package:proyectoppp/model/empresa.dart';

class TutorEmpresarial {
  final int id;
  final int rol;
  final String cargo;
  final Empresa empresa;
  final Usuario usuario;

  TutorEmpresarial(
      {required this.id,
      required this.rol,
      required this.cargo,
      required this.empresa,
      required this.usuario});
}
