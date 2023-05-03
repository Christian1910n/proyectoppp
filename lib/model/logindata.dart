class LoginData {
  String usuario;
  String contra;

  LoginData({required this.usuario, required this.contra});

  Map<String, dynamic> toJson() => {
        'usuario': usuario,
        'contra': contra,
      };
}
