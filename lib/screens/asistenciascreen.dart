import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:proyectoppp/model/estudiante.dart';
import 'package:proyectoppp/model/semanaActividad.dart';
import 'package:http/http.dart' as http;
import 'package:proyectoppp/utils/url.dart';
import 'package:intl/intl.dart';
import 'package:grouped_list/grouped_list.dart';

class AsistenciaEstudiante extends StatefulWidget {
  final Estudiante solicitudEstudiante;

  const AsistenciaEstudiante({required this.solicitudEstudiante});

  @override
  State<AsistenciaEstudiante> createState() => _AsistenciaEstudianteState();
}

class _AsistenciaEstudianteState extends State<AsistenciaEstudiante> {
  Estudiante? soliestudiante;
  List<SemanaActividad> listaactividad = [];

  Future<void> cargaractividades() async {
    var url = Uri.parse(
        '${enlace}semanaActividad/buscar/estudiante/${soliestudiante!.id}');

    var response = await http.get(url, headers: {"Authorization": tokenacceso});

    if (response.statusCode == 200) {
      var responseData = response.body;
      print(responseData);

      final jsonData = json.decode(response.body);
      setState(() {
        listaactividad = jsonData
            .map<SemanaActividad>((item) => SemanaActividad.fromJson(item))
            .toList();
      });
    } else {
      print('Error Semana Actividad: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    soliestudiante = widget.solicitudEstudiante;
    cargaractividades();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (listaactividad.isEmpty) {
      return Theme(
        data: ThemeData(brightness: Brightness.dark),
        child: Scaffold(
          appBar: AppBar(),
          body: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'LA ASISTENCIA NO HA SIDO REGISTRADA',
                  style: TextStyle(fontSize: 18),
                ),
              )),
        ),
      );
    }

    int totalHoras = listaactividad.fold(
        0, (sum, semanaActividad) => sum + semanaActividad.totalHoras);

    print("El total de horas es: $totalHoras");

    String? empresa = listaactividad[0]
        .practica
        .convocatoria
        .solicitudEmpresa!
        .convenio!
        .empresa!
        .nombre;

    final DateTime? fechaMinima = listaactividad.isNotEmpty
        ? listaactividad.map((actividad) => actividad.dia).reduce(
            (value, element) => value.isBefore(element) ? value : element)
        : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registro de Asistencia',
          style: (TextStyle(color: Colors.white)),
        ),
        backgroundColor: Color.fromARGB(255, 41, 36, 36),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Estudiante: ${soliestudiante!.usuario.nombre} ${soliestudiante!.usuario.apellido}',
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text(
              'Empresa: $empresa',
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  color: Colors.white,
                ),
                const SizedBox(width: 8),
                Text(
                  'Horas Cumplidas: $totalHoras',
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              'Registro de Asistencia Estudiante',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GroupedListView<SemanaActividad, int>(
                elements: listaactividad,
                groupBy: (actividad) {
                  final int numeroSemana =
                      ((actividad.dia.difference(fechaMinima!).inDays) / 7)
                          .floor();
                  return numeroSemana;
                },
                groupComparator: (value1, value2) => value1.compareTo(value2),
                groupSeparatorBuilder: (int value) => Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Semana ${value + 1}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                ),
                itemBuilder: (context, SemanaActividad actividad) {
                  final fecha = DateFormat('EEEE d \'de\' MMMM \'del\' y', 'es')
                      .format(actividad.dia);
                  final horaInicio = actividad.horaInicio.format(context);
                  final horaFin = actividad.horaFin.format(context);

                  return ListTile(
                    title: Text(
                      ' ${fecha.toUpperCase()}',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.timer, color: Colors.white),
                            const SizedBox(width: 4),
                            Text('Hora de entrada: $horaInicio',
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.timer_off, color: Colors.white),
                            const SizedBox(width: 4),
                            Text('Hora de salida: $horaFin',
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 41, 36, 36),
    );
  }
}
