import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyectoppp/model/convocatoria.dart';
import 'package:proyectoppp/pdf/solicitudEstudiante.dart';

class DetallesConvocatoria extends StatelessWidget {
  final Convocatoria convocatoria;

  DetallesConvocatoria(this.convocatoria);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de convocatoria'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'CONVOCATORIA PRACTICAS PRE PROFESIONALES - ${convocatoria.solicitudEmpresa.convenio.empresa.nombre}\n',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Estimados y estimadas estudiantes, buen día. Por medio del presente, como carrera de Tecnología Superior en Desarrollo de Software, queremos hacerles llegar la invitación para que participen en la convocatoria de prácticas pre profesionales en la empresa ${convocatoria.solicitudEmpresa.convenio.empresa.nombre}.\n' +
                    '\nA continuación, en el documento adjunto, encontrarán los detalles de las actividades a realizar, y los plazos que disponen para hacer llegar la solicitud correspondiente. \nNota: Adjunto a la solicitud se debe remitir la hoja de vida, para lo cual deberá registrarse en el portal web encuentraempleo,  e imprimir el currículo en formato moderno a través del siguiente enlace: \nhttps://encuentraempleo.trabajo.gob.ec\n',
                style: TextStyle(
                  fontSize: 16,
                  letterSpacing: 0.5, // Espaciado entre letras
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // Alinear a la derecha
              children: [
                Text(
                  'Fecha inicio: ${convocatoria.fechaInicio}\n',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Fecha fin: ${convocatoria.fechaFin}\n',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 20), // Espacio entre el texto y el botón
            Center(
              child: ElevatedButton(
                onPressed: () {
                  PdfGenerator.generatePdf(convocatoria);
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
