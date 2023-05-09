import 'package:flutter/material.dart';
import 'package:googleapis/servicemanagement/v1.dart';

String enlace = "http://192.168.68.110:8080/";

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

Container MenuEstudiante() {
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
                      const Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text(
                          "CHRISTIAN GARAICOA",
                          style: TextStyle(
                            color: Colors.blue,
                            fontFamily: 'cursive',
                            fontSize: 20.0,
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
                    // Handle onTap event
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
                    // Handle onTap event
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
              // Handle onTap event
            },
          ),
        ],
      ),
    ),
  );
}
