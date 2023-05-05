class Usuario {
  final int id;
  final int rol;
  final String cedula;
  final String nombre;
  final String apellido;
  final String correo;
  final String titulo;
  final String telefono;
  final bool activo;

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
}
