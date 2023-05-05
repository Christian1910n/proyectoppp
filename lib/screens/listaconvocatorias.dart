import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyectoppp/model/convocatoria.dart';
import 'package:proyectoppp/model/solicitudempresa .dart';

class listaConvocatoria extends StatefulWidget {
  @override
  _listaConvocatoriaState createState() => _listaConvocatoriaState();
}

class _listaConvocatoriaState extends State<listaConvocatoria> {
  List<Convocatoria> convocatorias = [];

  @override
  void initState() {
    super.initState();

    final url = Uri.parse('http://192.168.1.3:8080/convocatoria/listar');
    http.get(url).then((response) {
      final responseData = json.decode(response.body);
      final List<Convocatoria> loadedConvocatorias = [];

      for (var convocatoria in responseData) {
        SolicitudEmpresa? solicitudEmpresa;
        print(responseData);
        if (convocatoria['solicitudEmpresa'] != null) {
          solicitudEmpresa = SolicitudEmpresa(
            id: convocatoria['solicitudEmpresa']['id'],
            numPracticantes: convocatoria['solicitudEmpresa']['numPracticantes'],
            numHoras: convocatoria['solicitudEmpresa']['numHoras'],
            fechaInicioTen: convocatoria['solicitudEmpresa']['fechaInicioTen'],
            fechaMaxTen: convocatoria['solicitudEmpresa']['fechaMaxTen'],
            estado: convocatoria['solicitudEmpresa']['estado'],
            convenio: convocatoria['solicitudEmpresa']['convenio'] != null
                ? convocatoria['solicitudEmpresa']['convenio']['convenio']
                : null,
          );
        }

        if (solicitudEmpresa != null) {
          loadedConvocatorias.add(Convocatoria(
            id: convocatoria['id'],
            fechaInicio: DateTime.parse(convocatoria['fechaInicio']),
            fechaFin: DateTime.parse(convocatoria['fechaFin']),
            numero: convocatoria['numero'],
            solicitudEmpresa: solicitudEmpresa,
          ));
        }
      }

      setState(() {
        convocatorias = loadedConvocatorias;
      });
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
