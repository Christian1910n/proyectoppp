class Carrera {
  final int id;
  final int idCarrera;
  final String nombre;
  final bool activo;

  Carrera(
      {required this.id,
      required this.activo,
      required this.idCarrera,
      required this.nombre});

  factory Carrera.fromJson(Map<String, dynamic> json) {
    return Carrera(
        id: json['id'],
        idCarrera: json['idCarrera'],
        nombre: (json['nombre']),
        activo: (json['activo']));
  }
}
