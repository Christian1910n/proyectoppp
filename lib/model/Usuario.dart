class Usuario {
  int id;
  int rol;
  String cedula;
  String nombre;
  String apellido;
  String correo;
  String titulo;
  String telefono;
  bool activo;

  Usuario(
      {required this.id,
      required this.rol,
      required this.cedula,
      required this.nombre,
      required this.apellido,
      required this.correo,
      required this.titulo,
      required this.telefono,
      required this.activo});

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      rol: json['rol'],
      cedula: (json['cedula']),
      nombre: (json['nombre']),
      apellido: (json['apellido']),
      correo: (json['correo']),
      titulo: (json['titulo']),
      telefono: (json['telefono']),
      activo: (json['activo']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'rol': rol,
        'cedula': cedula,
        'nombre': nombre,
        'apellido': apellido,
        'correo': correo,
        'titulo': titulo,
        'telefono': telefono,
        'activo': activo
      };
}
