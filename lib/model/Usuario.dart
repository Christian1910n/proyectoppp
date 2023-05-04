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
}
