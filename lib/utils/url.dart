import 'package:flutter/material.dart';
import 'package:googleapis/servicemanagement/v1.dart';
import 'package:proyectoppp/screens/carrusel.dart';
import 'package:proyectoppp/screens/listaconvocatorias.dart';

import '../model/Usuario.dart';
import '../screens/Perfil.dart';

String enlace = "http://192.168.68.110:8080/";

String tokenacceso = '';
late var cookieacceso;

Future<dynamic> dialogoerror(mensaje, BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        title: const Text('            !!!ERROR!!!',
            style: TextStyle(color: Colors.red, fontFamily: 'papyrus')),
        content: Text(mensaje,
            style: const TextStyle(color: Colors.red, fontFamily: 'papyrus')),
        actions: <Widget>[
          TextButton(
            child: const Text('CERRAR',
                style: TextStyle(color: Colors.red, fontFamily: 'papyrus')),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<bool> mostrarConfirmacion(BuildContext context) async {
  return await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Confirmación"),
            content: const Text("¿Está seguro de que desea continuar?"),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("Cancelar"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text("Confirmar"),
              ),
            ],
          );
        },
      ) ??
      false;
}

final RegExp passwordRegExp =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
bool validatePassword(String password) {
  return passwordRegExp.hasMatch(password);
}

Container MenuEstudiante(Usuario usuario, BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.blue),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Drawer(
      backgroundColor: Colors.black,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 48, 4, 56),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 80.0,
                        child: Image.network(
                          'http://dev2020.tecazuay.edu.ec/wp-content/uploads/2022/11/cropped-LOGO-RECTANGULAR_SIN-FONDO.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text(
                          '${usuario.nombre} ${usuario.apellido}',
                          style: const TextStyle(
                            color: Colors.blue,
                            fontFamily: 'papyrus',
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: const Text(
                    'CONVOCATORIAS',
                    style: TextStyle(
                      color: Colors.blue,
                      fontFamily: 'papyrus',
                      fontSize: 15,
                    ),
                  ),
                  leading: const Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ),
                  tileColor: Colors.black,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              listaConvocatoria(usuario: usuario)),
                    );
                  },
                ),
                ListTile(
                  title: const Text(
                    'MI PERFIL',
                    style: TextStyle(
                      color: Colors.blue,
                      fontFamily: 'papyrus',
                      fontSize: 15,
                    ),
                  ),
                  leading: const Icon(
                    Icons.account_circle,
                    color: Colors.white,
                  ),
                  tileColor: Colors.black,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Perfil(usuario: usuario)),
                    );
                  },
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text(
              'CERRAR SESIÓN',
              style: TextStyle(
                color: Colors.blue,
                fontFamily: 'papyrus',
                fontSize: 15,
              ),
            ),
            leading: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            tileColor: Colors.black,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Carrusel()),
              );
              tokenacceso = '';
            },
          ),
        ],
      ),
    ),
  );
}

String toTitleCase(String text) {
  if (text == null) {
    return '';
  }
  return text
      .toLowerCase()
      .split(' ')
      .map((word) => word[0].toUpperCase() + word.substring(1))
      .join(' ');
}

String abreviarCarrera(String carrera) {
  List<String> palabras = carrera.split(' ');
  String abreviatura = '';
  for (int i = 0; i < palabras.length; i++) {
    if (palabras[i].isNotEmpty && palabras[i].length > 3) {
      abreviatura += palabras[i][0].toUpperCase();
    }
  }
  return abreviatura;
}
