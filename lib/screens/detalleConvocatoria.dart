import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:proyectoppp/model/Usuario.dart';
import 'package:proyectoppp/model/actividad.dart';
import 'package:proyectoppp/model/convocatoria.dart';
import 'package:proyectoppp/model/estudiante.dart';
import 'package:proyectoppp/screens/pdg_page.dart';
import 'package:proyectoppp/utils/url.dart';
import 'package:intl/date_symbol_data_local.dart';

class DetallesConvocatoria extends StatefulWidget {
  final Convocatoria convocatoria;
  final Usuario usuario;

  DetallesConvocatoria(this.convocatoria, this.usuario);

  @override
  _DetallesConvocatoriaState createState() => _DetallesConvocatoriaState();
}

class _DetallesConvocatoriaState extends State<DetallesConvocatoria> {
  List<Actividad> actividades = [];
  late Convocatoria _convocatoria;

  void listaractividaes() async {
    try {
      await initializeDateFormatting('es_ES');
      final url = Uri.parse(
          '${enlace}actividad/listarxSolicitudEmpresa2?id=${_convocatoria.solicitudEmpresa?.id.toString()}');
      List<Actividad> loadactividades = [];

      final response =
          await http.get(url, headers: {"Authorization": tokenacceso});
      print(response.body);

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        print(response.body);
        for (dynamic actividadJson in jsonResponse) {
          Actividad actividad = Actividad.fromJson(actividadJson);

          loadactividades.add(actividad);
        }
        setState(() {
          actividades = loadactividades;
        });
      } else {
        print('Error Actividades ${response.statusCode}');
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    _convocatoria = widget.convocatoria;
    listaractividaes();

    super.initState();
    print(actividades.length);
  }

  @override
  Widget build(BuildContext context) {
    final fechafin = DateFormat('EEEE dd \'de\' MMMM \'del\' y', 'es')
        .format(_convocatoria.fechaFin!);

    final materiasUnicas = <String>{};
    for (var actividad in actividades) {
      materiasUnicas.add(actividad.materia.nombre);
    }

    return Theme(
      data: ThemeData(brightness: Brightness.dark),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Convocatoria'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'CONVOCATORIA PRÁCTICAS PRE PROFESIONALES',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Empresa: ${_convocatoria.solicitudEmpresa!.convenio!.empresa!.nombre}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Se convoca a los estudiantes de la carrera de ${_convocatoria.solicitudEmpresa!.convenio!.carrera!.nombre} que deseen realizar sus prácticas preprofesionales en la empresa ${_convocatoria.solicitudEmpresa!.convenio!.empresa!.nombre}, a presentar la solicitud correspondiente.',
                style: const TextStyle(
                  fontSize: 16,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 25),
              const Text(
                'Actividades',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              if (actividades.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var actividad in actividades)
                      ListTile(
                        leading: const CircleAvatar(
                          radius: 4,
                          backgroundColor: Colors.black,
                        ),
                        title: Text(
                          actividad.descripcion,
                          style: const TextStyle(
                            fontSize: 16,
                            letterSpacing: 0.5,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                  ],
                ),
              if (actividades.isEmpty)
                const Text(
                  'No se han registrado actividades para esta convocatoria.',
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.justify,
                ),
              const SizedBox(height: 25),
              const Text(
                'Requisitos',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              if (actividades.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var materia in materiasUnicas)
                      ListTile(
                        leading: const CircleAvatar(
                          radius: 4,
                          backgroundColor: Colors.black,
                        ),
                        title: Text(
                          materia,
                          style: const TextStyle(
                            fontSize: 16,
                            letterSpacing: 0.5,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                  ],
                ),
              if (actividades.isEmpty)
                const Text(
                  'No se han registrado materias para esta convocatoria.',
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.justify,
                ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'La fecha máxima en la que se receptarán las solicitudes es el día $fechafin',
                  style: const TextStyle(
                    fontSize: 16,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PdfPage(_convocatoria, widget.usuario)),
                    );
                  },
                  child: Text('Postular'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
