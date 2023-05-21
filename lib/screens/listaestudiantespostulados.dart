import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proyectoppp/model/convocatoria.dart';
import 'package:proyectoppp/model/solicitudEstudiante.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyectoppp/screens/detallesEstudiante.dart';
import 'package:proyectoppp/utils/url.dart';

class EstudiantesPostuladosScreen extends StatefulWidget {
  final Convocatoria convocatoria;

  EstudiantesPostuladosScreen(this.convocatoria);

  @override
  _EstudiantesPostuladosScreenState createState() =>
      _EstudiantesPostuladosScreenState();
}

class _EstudiantesPostuladosScreenState
    extends State<EstudiantesPostuladosScreen> {
  List<SolicitudEstudiante> estudiantesPostulados = [];

  @override
  void initState() {
    super.initState();
    obtenerEstudiantesPostulados();
  }

  void obtenerEstudiantesPostulados() async {
    final url = Uri.parse(
        '${enlace}solicitudEstudiante/listarxconvocatoria2?id=${widget.convocatoria.id}');
    final response =
        await http.get(url, headers: {"Authorization": tokenacceso});

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print(responseData);
      List<SolicitudEstudiante> listaEstudiantes = [];

      for (final estudianteData in responseData) {
        final estudiante = SolicitudEstudiante.fromJson(estudianteData);
        listaEstudiantes.add(estudiante);
      }

      setState(() {
        estudiantesPostulados = listaEstudiantes;
      });
    } else {
      print('Error al obtener la lista de estudiantes postulados');
      print('Código de respuesta: ${response.statusCode}');
      print('Mensaje de error: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(brightness: Brightness.dark),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Estudiantes Postulados'),
        ),
        body: ListView.builder(
          itemCount: estudiantesPostulados.length,
          itemBuilder: (BuildContext context, int index) {
            final solicitud = estudiantesPostulados[index];
            final estudiante = solicitud.estudiante;
            final fechaInicio = DateFormat('dd/MM/yyyy')
                .format(estudiantesPostulados[index].fechaEnvio);

            return Column(
              children: [
                ListTile(
                  title: Text(
                    solicitud.estudiante.usuario.nombre.toString() +
                        ' ' +
                        solicitud.estudiante.usuario.apellido.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Cedula: ' +
                          solicitud.estudiante.usuario.cedula.toString()),
                      Text('Fecha: $fechaInicio'),
                      Text('Ciclo: ' + estudiante.ciclo),
                    ],
                  ),
                  onTap: () async {
                    final url = Uri.parse(
                        '${enlace}solicitudEstudiante/buscar/${solicitud.id}');
                    final response = await http
                        .get(url, headers: {"Authorization": tokenacceso});
                    if (response.statusCode == 200) {
                      final responseData = json.decode(response.body);
                      final estudiantes =
                          SolicitudEstudiante.fromJson(responseData);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetallesEstudianteScreen(estudiantes),
                        ),
                      );
                    } else {
                      print('Error al obtener los detalles del estudiante');
                    }
                  },
                ),
                Divider(), // Línea divisora
              ],
            );
          },
        ),
      ),
    );
  }
}
