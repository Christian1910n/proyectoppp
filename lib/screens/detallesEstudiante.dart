import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proyectoppp/model/convocatoria.dart';
import 'package:proyectoppp/model/solicitudEstudiante.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyectoppp/utils/url.dart';

class DetallesEstudianteScreen extends StatefulWidget {
  final SolicitudEstudiante solicitud;

  DetallesEstudianteScreen(this.solicitud);

  @override
  _DetallesEstudianteScreenState createState() =>
      _DetallesEstudianteScreenState();
}

class _DetallesEstudianteScreenState extends State<DetallesEstudianteScreen> {
  bool isChecked = false;

  void _updateSolicitudEstudiante(bool newValue) async {
    if (isChecked) {
      final url = Uri.parse(
          '${enlace}solicitudEstudiante/editarEstado/${widget.solicitud.id}?estado=1');
      final response =
          await http.put(url, headers: {"Authorization": tokenacceso});

      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        print('La solicitud ha sido actualizada');
        print(responseData);
      } else {
        final responseData = json.decode(response.body);
        print('Error al actualizar la solicitud');
        print(response.statusCode);
        print(tokenacceso);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(brightness: Brightness.dark),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Detalles del Estudiante'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.solicitud.estudiante.usuario.nombre} ${widget.solicitud.estudiante.usuario.apellido}\n',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              'Cédula: ${widget.solicitud.estudiante.usuario.cedula}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Periodo: ${widget.solicitud.estudiante.periodo}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Teléfono: ${widget.solicitud.estudiante.usuario.telefono}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Correo: ${widget.solicitud.estudiante.usuario.correo}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Ciclo: ${widget.solicitud.estudiante.ciclo}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Periodo: ${widget.solicitud.estudiante.periodo}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            CheckboxListTile(
              title: Text('Aprobar'),
              value: widget.solicitud.estado >
                  0, // Marcado si el estado es igual a 0
              onChanged: (bool? newValue) {
                setState(() {
                  isChecked = newValue ?? false;
                  print('ooooooooooooooooo');
                });

                if (isChecked) {
                  _updateSolicitudEstudiante(isChecked);

                  print('uuuuuuuuuuuuuuuuu');
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
