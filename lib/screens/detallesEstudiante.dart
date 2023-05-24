import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
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
  bool _loading = false;
  String ciclos = "";
  @override
  void initState() {
    if (widget.solicitud.estudiante.ciclo == 1) {
      ciclos = "PRIMER CICLO";
    } else if (widget.solicitud.estudiante.ciclo == 0) {
      ciclos = "EGRESADO";
    } else if (widget.solicitud.estudiante.ciclo == 2) {
      ciclos = "SEGUNDO CICLO";
    } else if (widget.solicitud.estudiante.ciclo == 3) {
      ciclos = "TERCER CICLO";
    } else if (widget.solicitud.estudiante.ciclo == 4) {
      ciclos = "CUARTO CICLO";
    } else if (widget.solicitud.estudiante.ciclo == 5) {
      ciclos = "QUINTO CICLO";
    } else if (widget.solicitud.estudiante.ciclo == 6) {
      ciclos = "SEXTO CICLO";
    }

    super.initState();
  }

  void editarSolicitudEstudiante(bool newValue) async {
    if (isChecked) {
      setState(() {
        _loading = true;
      });
      try {
        final url = Uri.parse(
            '${enlace}solicitudEstudiante/editarEstado/${widget.solicitud.id}?estado=1');
        final response =
            await http.put(url, headers: {"Authorization": tokenacceso});

        if (response.statusCode == 201) {
          print('La solicitud ha sido actualizada');
          setState(() {
            widget.solicitud.estado = 1;
          });
        } else {
          print('Error al actualizar la solicitud');
        }
      } catch (error) {
        print("Error SoliEstudiante $error");
      } finally {
        if (mounted) {
          setState(() {
            _loading = false;
          });
        }
      }
    }
  }

  void editarSolicitudEstudianteRechazar(bool newValue) async {
    if (isChecked) {
      setState(() {
        _loading = true;
      });
      try {
        final url = Uri.parse(
            '${enlace}solicitudEstudiante/editarEstado/${widget.solicitud.id}?estado=3');
        final response =
            await http.put(url, headers: {"Authorization": tokenacceso});

        if (response.statusCode == 201) {
          print('La solicitud ha sido actualizada ${response.body}');
          setState(() {
            widget.solicitud.estado = 3;
          });
        } else {
          print('Error al actualizar la solicitud');
        }
      } catch (error) {
        print("Error SoliEstudiante $error");
      } finally {
        if (mounted) {
          setState(() {
            _loading = false;
          });
        }
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
    final url = Uri.parse(
        '${enlace}solicitudEstudiante/mostrarpdf/${widget.solicitud.id}');
    try {
      final response =
          await http.get(url, headers: {"Authorization": tokenacceso});
      if (response.statusCode == 200) {
        final downloadsDirectory = await getExternalStorageDirectory();
        print(response.request);
        if (downloadsDirectory != null) {
          final file = File(
              '${downloadsDirectory.path}/${widget.solicitud.estudiante.usuario.cedula}.pdf');
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
    if (_loading) {
      return Center(
        child: Stack(
          children: [
            Lottie.network(
                'https://assets6.lottiefiles.com/packages/lf20_C67qsN3hAk.json'),

            //child: Lottie.asset('assets/loading.json'),
          ],
        ),
      );
    }

    return Theme(
      data: ThemeData(brightness: Brightness.dark),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Detalles del Estudiante'),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${widget.solicitud.estudiante.usuario.nombre} ${widget.solicitud.estudiante.usuario.apellido}\n',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                ListTile(
                  leading: Icon(Icons.credit_card),
                  title: Text(
                    'Cédula: ${widget.solicitud.estudiante.usuario.cedula}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.calendar_today),
                  title: Text(
                    'Periodo: ${widget.solicitud.estudiante.periodo}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text(
                    'Teléfono: ${widget.solicitud.estudiante.usuario.telefono}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.mail),
                  title: Text(
                    'Correo: ${widget.solicitud.estudiante.usuario.correo}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.circle),
                  title: Text(
                    'Ciclo: ${ciclos}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    descargarPDF();
                  },
                  child: Text('Descargar PDF'),
                ),
                CheckboxListTile(
                  title: Text('Aprobar'),
                  value: widget.solicitud.estado == 1 ||
                      widget.solicitud.estado == 2,
                  onChanged: (bool? newValue) {
                    setState(() {
                      isChecked = newValue ?? false;
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
        ),
      ),
    );
  }
}
