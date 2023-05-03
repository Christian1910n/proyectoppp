import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeGoogleSignIn extends StatefulWidget {
  @override
  State<HomeGoogleSignIn> createState() => _HomeGoogleSignInState();
}

class LoginData {
  String usuario;
  String contra;

  LoginData({required this.usuario, required this.contra});

  Map<String, dynamic> toJson() => {
        'usuario': usuario,
        'contra': contra,
      };
}

class _HomeGoogleSignInState extends State<HomeGoogleSignIn> {
  late LoginData _loginData;
  String _token = '';

  Future<void> login() async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.68.110:8080/api/usuarios/login'),
        body: _loginData.toJson(),
      );
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        _token = responseBody['token'];
        print(_token);
      } else {
        print(_loginData.contra);
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    _loginData = LoginData(usuario: '', contra: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
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
                'PRACTICAS',
                style: TextStyle(fontFamily: 'cursive', fontSize: 50.0),
              ),
              SizedBox(
                width: 160.0,
                height: 15.0,
                child: Divider(color: Colors.blueGrey[600]),
              ),
              TextField(
                enableInteractiveSelection: false,
                // autofocus: true,
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                    hintText: 'USER-NAME',
                    labelText: 'User name',
                    suffixIcon: const Icon(Icons.verified_user),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0))),
                onSubmitted: (valor) {
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
                obscureText: true,
                decoration: InputDecoration(
                    hintText: 'Password',
                    labelText: 'Password',
                    suffixIcon: const Icon(Icons.lock_outline),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0))),
                onSubmitted: (valor) {
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
                      backgroundColor: Colors.blue),
                  onPressed: () {
                    login();
                  },
                  child: const Text('Ingresar'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
