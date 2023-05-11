import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proyectoppp/model/convocatoria.dart';
import 'package:proyectoppp/model/solicitudEstudiante.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
    final url = Uri.parse('http://192.168.1.4:8080/solicitudEstudiante/listarxconvocatoria?id=${widget.convocatoria.id}');
    final response = await http.get(url);

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Estudiantes Postulados'),
      ),
      body: ListView.builder(
        itemCount: estudiantesPostulados.length,
        itemBuilder: (BuildContext context, int index) {
          final solicitud = estudiantesPostulados[index];
          final estudiante = solicitud.estudiante;
          final fechaInicio = DateFormat('dd/MM/yyyy').format(estudiantesPostulados[index].fechaEnvio!);

          return Column(
            children: [
              ListTile(
                title: Text(estudiante.carrera.nombre.toString()),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Estado: ${solicitud.estado ? 'Aprobado' : 'Pendiente'}'),
                    Text('Cedula: ' +solicitud.estudiante.usuario.cedula.toString()),
                    Text('Nombres: ' +solicitud.estudiante.usuario.nombre.toString()+' '+solicitud.estudiante.usuario.apellido.toString()),
                    Text('Fecha: $fechaInicio'),
                  ],
                ),
                onTap: () {
                  // Acciones al seleccionar un estudiante postulado
                },
              ),
              Divider(), // Línea divisora
            ],
          );
        },
      ),
    );
  }
}
