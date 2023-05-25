import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyectoppp/model/Usuario.dart';

import '../model/notificacion.dart';
import '../utils/url.dart';
import 'DetallePractica.dart';
import 'listaTutorEspecifico.dart';

class NotificacionesPage extends StatefulWidget {
  final Usuario usuario;
  final String rol;

  const NotificacionesPage({required this.usuario, required this.rol});

  @override
  _NotificacionesPageState createState() => _NotificacionesPageState();
}

class _NotificacionesPageState extends State<NotificacionesPage> {
  List<Notificacion> notificaciones = [];
  int tutorestudiante = 1;

  Future<void> listanotificaciones() async {
    final String url =
        '${enlace}notificacion/listar/${widget.usuario.id}/$tutorestudiante';
    final response =
        await http.get(Uri.parse(url), headers: {"Authorization": tokenacceso});

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      final List<Notificacion> notificacionesNuevas =
          jsonData.map((data) => Notificacion.fromJson(data)).toList();

      setState(() {
        notificaciones = notificacionesNuevas;
      });

      print("Notificaciones ${response.body}");
    } else {
      print('Error notificaciones: ${response.statusCode}');
    }
  }

  Future<void> marcarcomoleido(int id) async {
    final url = '${enlace}notificacion/editar/$id/false';

    try {
      final response = await http
          .post(Uri.parse(url), headers: {"Authorization": tokenacceso});
      if (response.statusCode == 201) {
        print('Notificación editada exitosamente');
      } else if (response.statusCode == 404) {
        print('Notificación no encontrada');
      } else {
        print('Error al editar la notificación');
      }
    } catch (e) {
      print('Error de conexión: $e');
    }
  }

  @override
  void initState() {
    if (widget.rol == 'ROLE_ESTUD') {
      tutorestudiante = 3;
    } else if (widget.rol == 'ROLE_TISTA') {
      tutorestudiante = 1;
    } else if (widget.rol == 'ROLE_TEMP') {
      tutorestudiante = 2;
    }
    listanotificaciones();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(brightness: Brightness.dark),
      child: Scaffold(
        backgroundColor: Colors.black12,
        body: ListView.builder(
          itemCount: notificaciones.length,
          itemBuilder: (context, index) {
            final notificacion = notificaciones[index];

            String mensaje;
            if (tutorestudiante == 3) {
              if (notificacion.tipo == 1) {
                mensaje =
                    'Se le ha asignado como tutor académico a "${notificacion.usuarioTutor.nombre} ${notificacion.usuarioTutor.apellido}"';
              } else {
                mensaje =
                    'Se le ha asignado como tutor especifico a "${notificacion.usuarioTutor.nombre} ${notificacion.usuarioTutor.apellido}"';
              }
            } else {
              mensaje =
                  'Se le ha asignado al estudiante "${notificacion.usuarioEstudiante.nombre} ${notificacion.usuarioEstudiante.apellido}"';
            }

            final bool leido = notificacion.estado;

            return ListTile(
              title: Row(
                children: [
                  Icon(
                    leido ? Icons.message : Icons.message,
                    color: leido ? Colors.blue : Colors.grey,
                  ),
                  SizedBox(width: 8),
                  Flexible(
                    child: Wrap(
                      children: [
                        Text(
                          mensaje,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              onTap: () {
                if (notificacion.estado == true) {
                  marcarcomoleido(notificacion.id);
                }
                if (widget.rol == "ROLE_ESTUD") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DetallePractica(usuario: widget.usuario)),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EstudiantesPostulados(
                            usuario: widget.usuario, rol: widget.rol)),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
