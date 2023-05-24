import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proyectoppp/model/convocatoria.dart';
import 'package:proyectoppp/model/solicitudEstudiante.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:proyectoppp/utils/url.dart';
import 'package:open_file/open_file.dart';



class DetallesEstudianteScreen extends StatefulWidget {
  final SolicitudEstudiante solicitud;

  DetallesEstudianteScreen(this.solicitud);

  @override
  _DetallesEstudianteScreenState createState() =>
      _DetallesEstudianteScreenState();
}

class _DetallesEstudianteScreenState extends State<DetallesEstudianteScreen> {
  bool isChecked = false;
  bool isSecondCheckboxEnabled = true;

  void editarSolicitudEstudiante(bool newValue) async {
    if (isChecked) {
      final url = Uri.parse(
          '${enlace}solicitudEstudiante/editarEstado/${widget.solicitud.id}?estado=1');
      final response =
          await http.put(url, headers: {"Authorization": tokenacceso});

      if (response.statusCode == 201) {
        print('La solicitud ha sido actualizada');
      } else {
        print('Error al actualizar la solicitud');
      }
    }
  }

  void editarSolicitudEstudianteRechazar(bool newValue) async {
    if (isChecked) {
      final url = Uri.parse(
          '${enlace}solicitudEstudiante/editarEstado/${widget.solicitud.id}?estado=3');
      final response =
          await http.put(url, headers: {"Authorization": tokenacceso});

      if (response.statusCode == 201) {
        print('La solicitud ha sido actualizada');
      } else {
        print('Error al actualizar la solicitud');
      }
    }
  }

  void Mensajes(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void DialagoConfirmacion(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmación'),
          content: Text('¿Seguro que quieres rechazar este estudiante?'),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
            ),
            TextButton(
              child: Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
                editarSolicitudEstudianteRechazar(true);
                Mensajes(context, 'Estudiante rechazado');
              },
            ),
          ],
        );
      },
    );
  }



// ...

void descargarPDF() async {
  final url = Uri.parse('${enlace}solicitudEstudiante/mostrarpdf/${widget.solicitud.id}');
  try {
    final response = await http.get(url, headers: {"Authorization": tokenacceso});
    if (response.statusCode == 200) {
      final downloadsDirectory = await getExternalStorageDirectory();
      print(response.request);
      if (downloadsDirectory != null) {
        final file = File('${downloadsDirectory.path}/${widget.solicitud.estudiante.usuario.cedula}.pdf');
        await file.writeAsBytes(response.bodyBytes);
        print(file);
        print('PDF descargado correctamente');
        
        // Abre el archivo PDF con la aplicación predeterminada del dispositivo
        OpenFile.open(file.path);
      } else {
        print('No se pudo obtener el directorio de descargas');
      }
    } else {
      print('Error al descargar el PDF');
    }
  } catch (e) {
    print('Error: $e');
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
            ElevatedButton(
              onPressed: () {
                descargarPDF();
              },
              child: Text('Descargar PDF'),
            ),
            CheckboxListTile(
              title: Text('Aprobar'),
              value:
                  widget.solicitud.estado == 1 || widget.solicitud.estado == 2,
              onChanged: (bool? newValue) {
                setState(() {
                  isChecked = newValue ?? false;
                  isSecondCheckboxEnabled = !isChecked;
                });

                if (isChecked) {
                  editarSolicitudEstudiante(isChecked);
                  Mensajes(context, 'Estudiante aprobado');
                }
              },
            ),
            CheckboxListTile(
              title: Text('Rechazar'),
              value: widget.solicitud.estado == 3,
              onChanged: isSecondCheckboxEnabled
                  ? (bool? newValue) {
                      setState(() {
                        isChecked = newValue ?? false;
                      });

                      if (isChecked) {
                        DialagoConfirmacion(context);
                      }
                    }
                  : null,
              enabled: isSecondCheckboxEnabled,
            ),
          ],
        ),
      ),
    );
  }
}
