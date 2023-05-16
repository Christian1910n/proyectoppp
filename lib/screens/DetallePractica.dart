import 'package:flutter/material.dart';
import 'package:proyectoppp/model/Usuario.dart';
import 'package:proyectoppp/model/practica.dart';
import 'package:proyectoppp/screens/registraractividades.dart';
import 'package:proyectoppp/utils/url.dart';

class DetallePractica extends StatefulWidget {
  final Usuario usuario;

  const DetallePractica({required this.usuario});

  @override
  State<DetallePractica> createState() => _DetallePracticaState();
}

class _DetallePracticaState extends State<DetallePractica> {
  Practica? practica;

  @override
  Widget build(BuildContext context) {
    if (practica == null) {
      return Theme(
        data: ThemeData(brightness: Brightness.dark),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Detalle de la práctica'),
          ),
          body: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'NO TIENE PRACTICA EN PROCESO',
                  style: TextStyle(fontSize: 18),
                ),
              )),
        ),
      );
    }

    return Theme(
      data: ThemeData(brightness: Brightness.dark),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Detalle de la práctica'),
        ),
        drawer: MenuEstudiante(widget.usuario, context, 'ROLE_ESTUD'),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Fecha de inicio: ${practica!.inicio.toString()}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              Text(
                'Fecha final tentativa: ${practica!.fin.toString()}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              Text(
                'Empresa: ${practica!.convocatoria.solicitudEmpresa!.convenio!.empresa}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              Text(
                'Tutor Específico: ${practica!.tutorEmpresarial.usuario.nombre}',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              Text(
                'Tutor Académico: ${practica!.tutorInstituto.usuario!.nombre}',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegistrarActividad()),
                  );
                },
                child: Text('Registrar asistencia'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
