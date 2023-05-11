class Empresa {
  final int id;
  String? ruc;
  String? nombre;
  String? matriz;
  String? mision;
  String? vision;
  String? objetivo;
  final bool activo;

  Empresa(
      {required this.id,
      this.ruc,
      this.nombre,
      this.matriz,
      this.mision,
      required this.activo,
      this.objetivo,
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
  Map<String, dynamic> toJson() => {
        'id': id,
        'ruc': ruc,
        'nombre': nombre,
        'matriz': matriz,
        'mision': mision,
        'activo': activo,
        'objetivo': objetivo,
        'vision': vision,
      };
}
