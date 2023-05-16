import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:proyectoppp/model/Usuario.dart';
import 'package:proyectoppp/screens/carrusel.dart';
import 'package:proyectoppp/model/logindata.dart';
import 'package:lottie/lottie.dart';
import 'package:proyectoppp/screens/listaconvocatorias.dart';

import '../sqlite/database.dart';
import '../utils/url.dart';

class HomeGoogleSignIn extends StatefulWidget {
  @override
  State<HomeGoogleSignIn> createState() => _HomeGoogleSignInState();
}

class _HomeGoogleSignInState extends State<HomeGoogleSignIn> {
  late LoginData _loginData;
  bool _showPassword = false;
  bool _loading = false;
  bool recordar = false;
  final TextEditingController _correo = TextEditingController();
  final TextEditingController _contra = TextEditingController();

  void _cargarcredenciales() async {
    // Verifica si se han almacenado las credenciales del usuario en la base de datos
    Map? credentials =
        await DatabaseHelper.instance.getCredentials(_correo.text);

    if (credentials != null) {
      // Si se han almacenado las credenciales, completa automáticamente los campos de nombre de usuario y contraseña
      _correo.text = credentials[DatabaseHelper.columnName];
      _contra.text = credentials[DatabaseHelper.columnPassword];
      recordar = true;
    }
  }

  Future<void> login() async {
    setState(() {
      _loading = true;
    });
    try {
      if (recordar) {
        await DatabaseHelper.instance
            .insertOrUpdateCredentials(_loginData.usuario, _loginData.contra);
      }

      final auth =
          'Basic ${base64Encode(utf8.encode('${_correo.text}:${_contra.text}'))}';

      final url = '${enlace}ingresar';
      final response =
          await http.get(Uri.parse(url), headers: {'Authorization': auth});

      if (response.statusCode == 200) {
        final token = response.headers['authorization'];
        print('Token de acceso: $token');
        tokenacceso = token!;

        final jsons = json.decode(response.body);
        final usuario = Usuario.fromJson(jsons);

        final cookie = response.headers['set-cookie'];
        cookieacceso = cookie;
        print('La cookie es: $cookie');

        final decodedToken = JwtDecoder.decode(token);
        final authorities = decodedToken['authorities'];
        print(authorities);
        if (authorities == 'ROLE_ESTUD') {
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => listaConvocatoria(usuario: usuario)),
          );
        } else if (authorities == 'ROLE_TEMP') {
          print('TUTOR ESPECIFICO');
        } else if (authorities == 'ROLE_TISTA') {
          print('TUTOR ACADEMICO');
        } else if (authorities == 'ROLE_RESPP') {
          print('RESPONSABLE DE PRACTICAS PPP');
        }
      } else {
        print('Error: ${response.statusCode}');
        dialogoerror('USUARIO O CONTRASEÑA INCORRECTA', context);
      }

      print(response.body);
    } catch (error) {
      print(error);
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loginData = LoginData(usuario: '', contra: '');
    _cargarcredenciales();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Center(
        child: Lottie.network(
            'https://assets6.lottiefiles.com/packages/lf20_C67qsN3hAk.json'),
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 4, 13, 17),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 90.0),
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Divider(
                height: 180.0,
              ),
              SizedBox(
                  child: ClipPath(
                child: Image.asset(
                  'assets/logoista.png',
                  fit: BoxFit.cover,
                ),
              )),
              const Text(
                'SISTEMA PPP',
                style: TextStyle(
                    fontFamily: 'cursive', fontSize: 50.0, color: Colors.white),
              ),
              const SizedBox(
                width: 160.0,
                height: 15.0,
                child: Divider(color: Color.fromARGB(255, 255, 255, 255)),
              ),
              TextField(
                enableInteractiveSelection: false,
                controller: _correo,
                decoration: InputDecoration(
                    hintText: 'USUARIO',
                    labelText: 'USUARIO',
                    suffixIcon: const Icon(Icons.verified_user),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0))),
                style: const TextStyle(color: Colors.white),
                onChanged: (valor) {
                  _cargarcredenciales();
                  setState(() {
                    _loginData.usuario = valor;
                  });
                },
              ),
              const Divider(
                height: 18.0,
              ),
              TextField(
                enableInteractiveSelection: false,
                obscureText: !_showPassword,
                controller: _contra,
                decoration: InputDecoration(
                    hintText: 'Password',
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: _showPassword
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0))),
                style: const TextStyle(color: Colors.white),
                onChanged: (valor) {
                  setState(() {
                    _loginData.contra = valor;
                  });
                },
              ),
              const Divider(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Checkbox(
                    value: recordar,
                    onChanged: (value) {
                      setState(() {
                        recordar = value!;
                      });
                    },
                  ),
                  const Text(
                    'Recordar contraseña',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(16.0),
                      textStyle: const TextStyle(fontSize: 20),
                      backgroundColor: const Color.fromARGB(255, 0, 84, 153)),
                  onPressed: () {
                    login();
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.login, size: 30),
                      SizedBox(width: 10),
                      Text(
                        'INGRESAR',
                        style: TextStyle(fontFamily: 'cursive', fontSize: 25),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
