import 'package:flutter/material.dart';
import 'package:proyectoppp/auth_with_google.dart';
import 'package:proyectoppp/model/firebase_user.dart';

class HomeGoogleSignIn extends StatefulWidget {
  @override
  State<HomeGoogleSignIn> createState() => _HomeGoogleSignInState();
}

class _HomeGoogleSignInState extends State<HomeGoogleSignIn> {
  final FirebaseUser _user = FirebaseUser();
  final AuthServiceGoogle _auth = AuthServiceGoogle();

  @override
  void initState() {
    super.initState();
    _user.user = _auth.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LOGIN'),
      ),
      body: Center(
        child: _user.uid != null ? _logged() : _login(),
      ),
    );
  }

  ElevatedButton _login() {
    return ElevatedButton.icon(
      icon: Icon(Icons.login),
      label: Text('Inicio de Sesión'),
      onPressed: () async {
        await _auth.signInGoogle();
        setState(() {
          _user.user = _auth.user;
        });
      },
    );
  }

  Column _logged() {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(_user.imageUrl!),
        ),
        Text(_user.name!),
        Text(_user.email!),
        ElevatedButton.icon(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _auth.signOutGoogle();
              setState(() {
                _user.user = _auth.user;
              });
            },
            label: const Text('Cerrar Sesión'))
      ],
    );
  }
}
