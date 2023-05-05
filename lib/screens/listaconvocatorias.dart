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

class listaConvocatoria extends StatefulWidget {
  @override
  _listaConvocatoriaState createState() => _listaConvocatoriaState();
}

class _listaConvocatoriaState extends State<listaConvocatoria> {
  List<Convocatoria> convocatorias = [];

  @override
  void initState() {
    super.initState();

    final url = Uri.parse('http://localhost:8080/convocatoria/listar');
    http.get(url).then((response) {
      final responseData = json.decode(response.body);
      final List<Convocatoria> loadedConvocatorias = [];

      for (final convocatoriaData in responseData) {
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
                fechaInicioTen: "12/12/12",
                fechaMaxTen: "12/12/12",
                estado: 0,
                convenio: Convenio(
                  id: 0,
                  numero: 0,
                  fechaInicio: "12/12/12",
                  fechaFin: "12/12/12",
                  empresa: Empresa(
                    id: 0,
                    ruc: '',
                    nombre: '',
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
                      child: Text('Opción 1'),
                    ),
                    PopupMenuItem(
                      child: Text('Opción 2'),
                    ),
                    PopupMenuItem(
                      child: Text('Opción 3'),
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
            Text('Lista de convocatorias',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: convocatorias.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                      convocatorias[index].solicitudEmpresa.estado.toString()),
                  subtitle: Text(
                      '${convocatorias[index].fechaInicio} - ${convocatorias[index].fechaFin}'),
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
