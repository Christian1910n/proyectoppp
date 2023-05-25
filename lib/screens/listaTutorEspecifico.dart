import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyectoppp/model/estudiante.dart';
import 'package:proyectoppp/model/tutorEmpresarial.dart';
import 'package:proyectoppp/model/Usuario.dart';
import 'package:proyectoppp/model/tutorInstituto.dart';
import 'package:proyectoppp/screens/asistenciascreen.dart';
import '../utils/url.dart';

class EstudiantesPostulados extends StatefulWidget {
  final Usuario usuario;
  final String rol;

  EstudiantesPostulados({required this.usuario, required this.rol});

  @override
  _EstudiantesPostuladosState createState() => _EstudiantesPostuladosState();
}

class _EstudiantesPostuladosState extends State<EstudiantesPostulados> {
  late Usuario usuario;
  List<Estudiante> estudiantes = [];

  @override
  void initState() {
    usuario = widget.usuario;
    super.initState();
    if (widget.rol == 'ROLE_TISTA') {
      listaestudiantesInstituto();
    } else if (widget.rol == 'ROLE_TEMP') {
      listaestudiantesEmpresarial();
    }
  }

  Future<void> listaestudiantesInstituto() async {
    final url =
        Uri.parse('${enlace}tutorInstituto/buscarxusuario/${usuario.id}');
    try {
      final response = await http.get(
        url,
        headers: {"Authorization": tokenacceso},
      );
      print(url);
      if (response.statusCode == 200) {
        final estudianteJson = response.body;
        tutorInstitutoback =
            TutorInstituto.fromJson(jsonDecode(estudianteJson));
        fetchEstudiantesPostulados();
      } else {
        print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> listaestudiantesEmpresarial() async {
    final url = Uri.parse('${enlace}tutorEmpresa/buscarxusuario/${usuario.id}');
    try {
      final response = await http.get(
        url,
        headers: {"Authorization": tokenacceso},
      );
      if (response.statusCode == 200) {
        final estudianteJson = response.body;
        tutorEmpresarialback =
            TutorEmpresarial.fromJson(jsonDecode(estudianteJson));
        fetchEstudiantesPostuladosEmpresa();
      } else {
        print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (error) {
      print(error);
    }
  }

  void fetchEstudiantesPostulados() async {
    final url = Uri.parse(
        '${enlace}estudiante/listarxtutoracademico/${tutorInstitutoback!.id}');
    final response =
        await http.get(url, headers: {"Authorization": tokenacceso});
    print(url);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        estudiantes = jsonData
            .map<Estudiante>((item) => Estudiante.fromJson(item))
            .toList();
      });
    } else {
      print('Error al obtener la lista de estudiantes postulados');
    }
  }

  void fetchEstudiantesPostuladosEmpresa() async {
    final url = Uri.parse(
        '${enlace}estudiante/listarxtutorempresarial/${tutorEmpresarialback!.id}');
    final response =
        await http.get(url, headers: {"Authorization": tokenacceso});
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        estudiantes = jsonData
            .map<Estudiante>((item) => Estudiante.fromJson(item))
            .toList();
      });
    } else {
      print('Error al obtener la lista de estudiantes postulados');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (estudiantes.isEmpty) {
      return WillPopScope(
        onWillPop: () async {
          // Bloquea el botón de retroceso
          return false;
        },
        child: Theme(
          data: ThemeData(brightness: Brightness.dark),
          child: Scaffold(
            appBar: AppBar(),
            drawer: MenuEstudiante(usuario, context, widget.rol),
            body: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    'NO HAY ESTUDIANTES POSTULADOS VUELVE PRONTO',
                    style: TextStyle(fontSize: 18),
                  ),
                )),
          ),
        ),
      );
    }
    return WillPopScope(
      onWillPop: () async {
        // Bloquea el botón de retroceso
        return false;
      },
      child: Theme(
        data: ThemeData(
          brightness: Brightness.dark,
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFF2196F3),
            secondary: Color(0xFFFFC107),
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Lista de estudiantes'),
          ),
          drawer: MenuEstudiante(usuario, context, widget.rol),
          body: ListView.separated(
            itemCount: estudiantes.length,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              final estudiante = estudiantes[index];
              return ListTile(
                title: Text(
                  estudiante.usuario.nombre.toString() +
                      ' ' +
                      estudiante.usuario.apellido.toString(),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Carrera: ' + estudiante.carrera.nombre.toString(),
                      style: TextStyle(color: Color.fromARGB(255, 28, 148, 68)),
                    ),
                    Text('Periodo: ' + estudiante.periodo.toString(),
                        style: TextStyle(
                            color: Color.fromARGB(255, 223, 136, 37))),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AsistenciaEstudiante(
                            solicitudEstudiante: estudiante)),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
