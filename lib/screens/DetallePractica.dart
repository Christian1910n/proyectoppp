import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:proyectoppp/model/Usuario.dart';
import 'package:proyectoppp/model/practica.dart';
import 'package:proyectoppp/screens/registraractividades.dart';
import 'package:proyectoppp/utils/url.dart';
import 'package:http/http.dart' as http;

class DetallePractica extends StatefulWidget {
  final Usuario usuario;

  const DetallePractica({required this.usuario});

  @override
  State<DetallePractica> createState() => _DetallePracticaState();
}

class _DetallePracticaState extends State<DetallePractica> {
  Practica? practica;

  Future<Practica?> cargarpractica() async {
    final url =
        Uri.parse('${enlace}practica/buscarxestudiante/${estudianteback!.id}');

    final response = await http.get(
      url,
      headers: {"Authorization": tokenacceso},
    );

    if (response.statusCode == 200) {
      final practicaJson = response.body;
      print('RESPONSE PRACTICA: ${response.body}');
      return Practica.fromJson(jsonDecode(practicaJson));
    } else {
      print('Error en la solicitud: ${response.statusCode}');
      return null;
    }
  }

  @override
  void initState() {
    cargarpractica();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('dd \'de\' MMMM \'del\' y', 'es');
    return FutureBuilder<Practica?>(
      future: cargarpractica(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Lottie.network(
                'https://assets6.lottiefiles.com/packages/lf20_C67qsN3hAk.json'),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error al cargar la práctica'),
          );
        } else if (snapshot.data == null) {
          return Theme(
            data: ThemeData(brightness: Brightness.dark),
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Detalle de la práctica'),
              ),
              drawer: MenuEstudiante(widget.usuario, context, 'ROLE_ESTUD'),
              body: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    'NO TIENE PRACTICA EN PROCESO',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          );
        } else {
          final practica = snapshot.data!;
          return Theme(
            data: ThemeData(
              brightness: Brightness.dark,
            ),
            child: Center(
              child: Scaffold(
                appBar: AppBar(
                  title: const Text('Detalle de la práctica'),
                ),
                drawer: MenuEstudiante(widget.usuario, context, 'ROLE_ESTUD'),
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Fecha de inicio:',
                        style: TextStyle(fontSize: 25, fontFamily: 'papyrus'),
                      ),
                      Text(
                        dateFormat.format(practica.inicio),
                        style: const TextStyle(
                            fontSize: 25, fontFamily: 'papyrus'),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Fecha final tentativa:',
                        style: TextStyle(fontSize: 25, fontFamily: 'papyrus'),
                      ),
                      Text(
                        dateFormat.format(practica.fin),
                        style: const TextStyle(
                            fontSize: 25, fontFamily: 'papyrus'),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Empresa:',
                        style: TextStyle(fontSize: 25, fontFamily: 'papyrus'),
                      ),
                      Text(
                        practica.convocatoria.solicitudEmpresa!.convenio!
                            .empresa!.nombre!,
                        style: const TextStyle(
                            fontSize: 25, fontFamily: 'papyrus'),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Tutor Específico:',
                        style: TextStyle(fontSize: 25, fontFamily: 'papyrus'),
                      ),
                      Text(
                        '${practica.tutorEmpresarial.usuario.nombre} ${practica.tutorEmpresarial.usuario.apellido}',
                        style: const TextStyle(
                            fontSize: 15, fontFamily: 'papyrus'),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Tutor Académico:',
                        style: TextStyle(fontSize: 25, fontFamily: 'papyrus'),
                      ),
                      Text(
                        '${practica.tutorInstituto.usuario!.nombre} ${practica.tutorInstituto.usuario!.apellido}',
                        style: const TextStyle(
                            fontSize: 16, fontFamily: 'papyrus'),
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegistrarActividad(),
                            ),
                          );
                        },
                        child: const Text('Registrar asistencia'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
