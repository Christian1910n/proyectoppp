import 'package:flutter/material.dart';
import 'package:proyectoppp/model/convocatoria.dart'; // Importa el modelo de Estudiante

class EstudiantesPostulados extends StatelessWidget {
  final List<Convocatoria> convocatoria; // Lista de estudiantes postulados

  EstudiantesPostulados(this.convocatoria);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estudiantes Postulados'),
      ),
      body: ListView.builder(
        itemCount: convocatoria.length,
        itemBuilder: (context, index) {
          final convocatorias = convocatoria[index];

          return ListTile(
            title: Text(convocatorias.solicitudEmpresa.toString()),
            subtitle: Text(convocatorias.solicitudEmpresa.numPracticantes.toString()),
            
          );
        },
      ),
    );
  }
}
