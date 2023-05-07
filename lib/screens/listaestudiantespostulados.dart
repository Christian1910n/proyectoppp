import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyectoppp/model/Carrera.dart';
import 'package:proyectoppp/model/Usuario.dart';
import 'package:proyectoppp/model/convenio.dart';
import 'package:proyectoppp/model/convocatoria.dart';
import 'package:proyectoppp/model/empresa.dart';
import 'package:proyectoppp/model/solicitudempresa .dart';
import 'package:proyectoppp/model/tutorInstituto.dart';

import '../utils/url.dart';

class listaEstudiantesPostulados extends StatefulWidget {
  @override
  _listaEstudiantesPostuladosState createState() => _listaEstudiantesPostuladosState();
}

class _listaEstudiantesPostuladosState extends State<listaEstudiantesPostulados> {
  List<Convocatoria> convocatorias = [];

  @override
  void initState() {
    super.initState();

    final url = Uri.parse('${enlace}convocatoria/listar');
    http.get(url).then((response) {
      final responseData = json.decode(response.body);
      final List<Convocatoria> loadedConvocatorias = [];

      for (final convocatoriaData in responseData) {
        print(responseData);
        final solicitudEmpresaData = convocatoriaData['solicitudEmpresa'];

        final solicitudEmpresa = solicitudEmpresaData != null
            ? SolicitudEmpresa(
                id: solicitudEmpresaData['id'],
                numPracticantes: solicitudEmpresaData['numPracticantes'],
                numHoras: solicitudEmpresaData['numHoras'],
                fechaInicioTen: (solicitudEmpresaData['fechaInicioTen']),
                fechaMaxTen: (solicitudEmpresaData['fechaMaxTen']),
                estado: solicitudEmpresaData['estado'],
                convenio: Convenio.fromJson(solicitudEmpresaData['convenio']),
              )
            : SolicitudEmpresa(
                id: 0,
                numPracticantes: 0,
                numHoras: 0,
                fechaInicioTen: "2023-05-04",
                fechaMaxTen: "2023-05-04",
                estado: 0,
                convenio: Convenio(
                  id: 0,
                  numero: 0,
                  fechaInicio: "2023-05-04",
                  fechaFin: "2023-05-04",
                  empresa: Empresa(
                    id: 0,
                    ruc: '',
                    nombre: 'Libelula software',
                    matriz: '',
                    mision: '',
                    vision: '',
                    objetivo: '',
                    activo: false,
                  ),
                  carrera: Carrera(
                    id: 0,
                    idCarrera: 0,
                    nombre: '',
                    activo: false,
                  ),
                  firmaInst: TutorInstituto(
                    id: 0,
                    idDocente: '',
                    rol: 0,
                    usuario: Usuario(
                      id: 0,
                      rol: 0,
                      cedula: '',
                      nombre: '',
                      apellido: '',
                      correo: '',
                      titulo: '',
                      telefono: '',
                      activo: false,
                    ),
                  ),
                ),
              );

        loadedConvocatorias.add(Convocatoria(
          id: convocatoriaData['id'],
          fechaInicio: convocatoriaData['fechaInicio'],
          fechaFin: convocatoriaData['fechaFin'],
          numero: convocatoriaData['numero'],
          solicitudEmpresa: solicitudEmpresa,
        ));
        print(loadedConvocatorias);
      }

      setState(() {
        convocatorias = loadedConvocatorias;
      });
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Buscar',
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search),
            suffixIcon: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                PopupMenuButton(
                  itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                    PopupMenuItem(
                      child: Text('Nombre'),
                    ),
                    PopupMenuItem(
                      child: Text('Fecha'),
                    ),
                  ],
                  icon: Icon(Icons.more_vert),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            Text('Estudiantes Postulados',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: convocatorias.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    convocatorias[index]
                        .solicitudEmpresa
                        .convenio
                        .empresa
                        .nombre
                        .toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Fecha inicio:\n',
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                              text: convocatorias[index].fechaFin.toString(),
                              style: TextStyle(
                                color: Color.fromARGB(255, 7, 178, 67),
                              ),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Fecha fin:\n',
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                              text: convocatorias[index].fechaInicio.toString(),
                              style: TextStyle(
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    // Acción al hacer tap en el elemento
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) => Divider(),
            ),
          ],
        ),
      ),
    );
  }
}
