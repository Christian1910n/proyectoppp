class Usuario {
  int id;
  String cedula;
  String nombre;
  String apellido;
  String correo;
  String titulo;
  String telefono;
  bool activo;
  String password;

  Usuario(
      {required this.id,
      required this.cedula,
      required this.nombre,
      required this.apellido,
      required this.correo,
      required this.titulo,
      required this.telefono,
      required this.activo,
      required this.password});

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
        id: json['id'],
        cedula: (json['cedula']),
        nombre: (json['nombre']),
        apellido: (json['apellido']),
        correo: (json['correo']),
        titulo: (json['titulo']),
        telefono: (json['telefono']),
        activo: (json['activo']),
        password: json['password'] ?? '');
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'cedula': cedula,
        'nombre': nombre,
        'apellido': apellido,
        'correo': correo,
        'titulo': titulo,
        'telefono': telefono,
        'activo': activo,
        'password': password
      };
}
