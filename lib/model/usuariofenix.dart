class UsuarioFenix {
  final int alumno_docenteId;
  final String cedula;
  final String nombres;
  final String apellidos;
  final String correo;
  final String telefono;
  final String titulo;
  final int ciclo;
  final int carreraId;
  final String periodo;
  final int tipo;

  UsuarioFenix(
      {required this.alumno_docenteId,
      required this.cedula,
      required this.apellidos,
      required this.nombres,
      required this.carreraId,
      required this.ciclo,
      required this.correo,
      required this.periodo,
      required this.telefono,
      required this.tipo,
      required this.titulo});

  factory UsuarioFenix.fromJson(Map<String, dynamic> json) {
    return UsuarioFenix(
      alumno_docenteId: json['alumno_docenteId'],
      cedula: json['cedula'],
      apellidos: (json['apellidos']),
      nombres: (json['nombres']),
      carreraId: (json['carreraId']),
      ciclo: (json['ciclo']),
      correo: (json['correo']),
      telefono: (json['telefono']),
      tipo: (json['tipo']),
      titulo: (json['titulo']),
      periodo: (json['periodo']),
    );
  }
}
