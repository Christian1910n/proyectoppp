class Empresa {
  final int id;
  final String ruc;
  final String nombre;
  final String matriz;
  final String mision;
  final String vision;
  final String objetivo;
  final bool activo;

  Empresa(
      {required this.id,
      required this.ruc,
      required this.nombre,
      required this.matriz,
      required this.mision,
      required this.activo,
      required this.objetivo,
      required this.vision});

  factory Empresa.fromJson(Map<String, dynamic> json) {
    return Empresa(
      id: json['id'],
      ruc: json['ruc'],
      nombre: (json['nombre']),
      matriz: (json['matriz']),
      mision: (json['mision']),
      activo: (json['activo']),
      objetivo: (json['objetivo']),
      vision: (json['vision']),
    );
  }
}
