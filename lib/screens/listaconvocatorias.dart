import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyectoppp/model/convocatoria.dart';
import 'package:proyectoppp/model/estudiante.dart';
import 'package:proyectoppp/screens/detalleConvocatoria.dart';
import 'package:intl/intl.dart';
import 'package:proyectoppp/screens/listaestudiantespostulados.dart';

import '../model/Usuario.dart';
import '../utils/url.dart';

class listaConvocatoria extends StatefulWidget {
  final Usuario usuario;
  final String rol;

  listaConvocatoria({required this.usuario, required this.rol});

  @override
  _listaConvocatoriaState createState() => _listaConvocatoriaState();
}

class _listaConvocatoriaState extends State<listaConvocatoria> {
  List<Convocatoria> convocatorias = [];
  late Usuario usuario;

  @override
  void initState() {
    usuario = widget.usuario;

    super.initState();
    if (widget.rol == 'ROLE_ESTUD') {
      buscarestudiante();
    } else {
      responsableppp();
    }
    // listarconvocatorias();
  }

  Future<void> buscarestudiante() async {
    final url = Uri.parse('${enlace}estudiante/buscarxusuario/${usuario.id}');

    try {
      final response = await http.get(
        url,
        headers: {"Authorization": tokenacceso},
      );

      if (response.statusCode == 200) {
        final estudianteJson = response.body;
        estudianteback = Estudiante.fromJson(jsonDecode(estudianteJson));
        print(estudianteJson);
        if (estudianteback!.ciclo == 5) {
          ciclo = 'del quinto ciclo';
        } else if (estudianteback!.ciclo == 4) {
          ciclo = 'del cuarto ciclo';
        } else if (estudianteback!.ciclo == 3) {
          ciclo = 'del tercer ciclo';
        } else if (estudianteback!.ciclo == 2) {
          ciclo = 'del segundo ciclo';
        } else if (estudianteback!.ciclo == 1) {
          ciclo = 'del primer ciclo';
        } else if (estudianteback!.ciclo == 0) {
          ciclo = 'egresado';
        }

        periodo = estudianteback!.periodo;
        carreraestudiante = toTitleCase(estudianteback!.carrera.nombre!);
      } else {
        print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (error) {
      print(error);
    } finally {
      listarconvocatoriasestudiante();
    }
  }

  void listarconvocatoriasestudiante() async {
    final url = Uri.parse(
        '${enlace}convocatoria/convocatoriasactivas?idCarrera=${estudianteback!.carrera.id}');
    print(url);
    List<Convocatoria> convocatoriass = [];

    try {
      final token = tokenacceso;
      final response = await http.get(
        url,
        headers: {"Authorization": token},
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        print(response.body);
        for (dynamic convocatoriaJson in jsonResponse) {
          Convocatoria convocatoria = Convocatoria.fromJson(convocatoriaJson);
          if (convocatoria.solicitudEmpresa?.convenio != null) {
            String empresaNombre =
                convocatoria.solicitudEmpresa!.convenio!.empresa?.nombre ?? "";
            convocatoria.solicitudEmpresa!.convenio!.empresa?.nombre =
                empresaNombre;
          }
          convocatoriass.add(convocatoria);
          setState(() {
            convocatorias = convocatoriass;
          });
        }
      }
    } catch (error) {
      print('Error Lista Convocatorias> $error');
    }
  }

  void responsableppp() async {
    final url = Uri.parse('${enlace}convocatoria/listar');
    print(url);
    List<Convocatoria> convocatoriass = [];

    try {
      final token = tokenacceso;
      final response = await http.get(
        url,
        headers: {"Authorization": token},
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        print(response.body);
        for (dynamic convocatoriaJson in jsonResponse) {
          Convocatoria convocatoria = Convocatoria.fromJson(convocatoriaJson);
          if (convocatoria.solicitudEmpresa?.convenio != null) {
            String empresaNombre =
                convocatoria.solicitudEmpresa!.convenio!.empresa?.nombre ?? "";
            convocatoria.solicitudEmpresa!.convenio!.empresa?.nombre =
                empresaNombre;
          }
          convocatoriass.add(convocatoria);
          setState(() {
            convocatorias = convocatoriass;
          });
        }
      }
    } catch (error) {
      print('Error Lista Convocatorias> $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (convocatorias.isEmpty) {
      return WillPopScope(
        onWillPop: () async {
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
                    'NO HAY CONVOCATORIAS DISPONIBLES VUELVE PRONTO',
                    style: TextStyle(fontSize: 18),
                  ),
                )),
          ),
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async {
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
          appBar: AppBar(),
          drawer: MenuEstudiante(usuario, context, widget.rol),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Text('Lista de convocatorias',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: convocatorias.length,
                  itemBuilder: (BuildContext context, int index) {
                    final fechaInicio = DateFormat('dd/MM/yyyy')
                        .format(convocatorias[index].fechaInicio!);
                    final fechaFin = DateFormat('dd/MM/yyyy')
                        .format(convocatorias[index].fechaFin!);
                    return ListTile(
                      title: Text(
                        "CONVOCATORIA PRACTICAS PRE PROFESIONALES - ${convocatorias[index].solicitudEmpresa!.convenio!.empresa!.nombre}",
                        style: const TextStyle(
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
                                  text: fechaInicio,
                                  style: const TextStyle(
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
                                  text: fechaFin,
                                  style: const TextStyle(
                                    color: Colors.orange,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        print('ROL:  ${widget.rol}');
                        if (widget.rol == 'ROLE_ESTUD') {
                          print('ESTUDIANTE');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetallesConvocatoria(
                                    convocatorias[index], usuario),
                              ));
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EstudiantesPostuladosScreen(
                                        convocatorias[index])),
                          );
                        }
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
