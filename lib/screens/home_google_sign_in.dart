import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyectoppp/screens/carrusel.dart';
import 'package:proyectoppp/model/logindata.dart';
import 'package:lottie/lottie.dart';

import '../utils/url.dart';

class HomeGoogleSignIn extends StatefulWidget {
  @override
  State<HomeGoogleSignIn> createState() => _HomeGoogleSignInState();
}

class _HomeGoogleSignInState extends State<HomeGoogleSignIn> {
  late LoginData _loginData;
  String _token = '';
  bool _showPassword = false;
  bool _loading = false;

  Future<void> login() async {
    setState(() {
      _loading = true;
    });

    /*
    try {
      final response = await http.post(
        Uri.parse('${enlace}api/usuarios/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(_loginData.toJson()),
      );
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        _token = responseBody['token'];

        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Carrusel()),
        );
      } else {
        print('${_loginData.usuario}h');
        print('${_loginData.contra}h');
        // ignore: use_build_context_synchronously
        dialogoerror('USUARIO O CONTRASEÑA INCORRECTA', context);
      }
    } catch (error) {
      print(error);
    } finally {
      setState(() {
        _loading = false;
      });
    }
    */
  }

  @override
  void initState() {
    super.initState();
    _loginData = LoginData(usuario: '', contra: '');
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
                decoration: InputDecoration(
                    hintText: 'USUARIO',
                    labelText: 'USUARIO',
                    suffixIcon: const Icon(Icons.verified_user),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0))),
                style: const TextStyle(color: Colors.white),
                onChanged: (valor) {
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
