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
