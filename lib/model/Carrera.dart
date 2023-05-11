class Carrera {
  int? id;
  int? idCarrera;
  String? nombre;
  bool? activo;

  Carrera({this.id, this.activo, this.idCarrera, this.nombre});

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
