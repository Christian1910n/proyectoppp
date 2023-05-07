class Carrera {
  int id;
  int idCarrera;
  String nombre;
  bool activo;

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

  Map<String, dynamic> toJson() =>
      {'id': id, 'idCarrera': idCarrera, 'nombre': nombre, 'acttivo': activo};
}
