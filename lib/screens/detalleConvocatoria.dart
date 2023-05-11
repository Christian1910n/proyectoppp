import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyectoppp/model/actividad.dart';
import 'package:proyectoppp/model/convocatoria.dart';
import 'package:proyectoppp/screens/pdg_page.dart';
import 'package:proyectoppp/utils/url.dart';

class DetallesConvocatoria extends StatefulWidget {
  final Convocatoria convocatoria;

  DetallesConvocatoria(this.convocatoria);

  @override
  _DetallesConvocatoriaState createState() => _DetallesConvocatoriaState();
}

class _DetallesConvocatoriaState extends State<DetallesConvocatoria> {
  List<Actividad> actividades = [];
  late Convocatoria _convocatoria;

  Future<List<Actividad>> obtenerActividadesPorSolicitudEmpresa() async {
    final url = Uri.parse(
        'http://localhost:8080/actividad/listarxSolicitudEmpresa?solicitudEmpresa=${json.encode(_convocatoria.solicitudEmpresa)}');
    final response =
        await http.get(url, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final List<dynamic> actividadesJson = json.decode(response.body);
      return actividadesJson.map((json) => Actividad.fromJson(json)).toList();
    } else {
      throw Exception(
          'Error al obtener las actividades: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    _convocatoria = widget.convocatoria;
    actividades = obtenerActividadesPorSolicitudEmpresa() as List<Actividad>;

    super.initState();
    print(actividades.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de convocatoria'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'CONVOCATORIA PRACTICAS PRE PROFESIONALES - ${_convocatoria.solicitudEmpresa!.convenio!.empresa!.nombre}\n',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Se convoca a los estudiantes de la carrera de ${_convocatoria.solicitudEmpresa!.convenio!.carrera!.nombre} que deseen realizar sus prácticas preprofesionales en la empresa ${_convocatoria.solicitudEmpresa!.convenio!.empresa!.nombre}, a presentar la solicitud correspondiente.',
                style: const TextStyle(
                  fontSize: 16,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 20), // Espacio entre el texto y el botón
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Las actividades a desarrollar son:',
                style: TextStyle(
                  fontSize: 16,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            if (actividades.isNotEmpty)
              Column(
                children: [
                  for (var actividad in actividades)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
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
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Por lo que los postulantes deberán haber aprobado las siguientes asignaturas:',
                style: TextStyle(
                  fontSize: 16,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 20), // Espacio entre el texto y el botón
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PdfPage()),
                  );
                },
                child: Text('Postular'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
