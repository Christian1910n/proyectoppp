import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

//Variables documento
const String fecha = "Cuenca, 14 de febrero del 202";
const String responsablepp = "Ing. Juan Gabriel Espinoza. Mgtr.";
const String carrera = "TSDS";
const String nombres = "GARAICOA CARABAJO CHRISTIAN FERNANDO";
const String cedula = "0105578173";
const String ciclo = "egresado";
//const String ciclo = "del quinto ciclo";

const String periodo = "Noviembre 2022 - Marzo 2023 ";
const String empresa = "KAMAYTECH";
const String nomconvocatoria = "CONVOCATORIA - TSDS -PPP-2023-00X";
const String nyapellido = "Christian Garaicoa";
const String celular = "0992087790";
const String correo = "christian.garaicoa.est@tecazuay.edu.ec";

Future<Uint8List> generatePdf(final PdfPageFormat format) async {
  final doc = pw.Document(title: 'Solicitud de Practicas PPP');
  final logoImage = pw.MemoryImage(
    (await rootBundle.load('assets/logoista.png')).buffer.asUint8List(),
  );
  final footerImage = pw.MemoryImage(
    (await rootBundle.load('assets/logoista.png')).buffer.asUint8List(),
  );

  final pageTheme = await _myPageTheme(format);

  doc.addPage(
    pw.MultiPage(
      header: (final context) => pw.Image(
        alignment: pw.Alignment.topLeft,
        logoImage,
        fit: pw.BoxFit.contain,
        width: 150,
      ),
      build: (final context) => [
        pw.Align(
          alignment: pw.Alignment.centerLeft,
          child: pw.Padding(
            padding: pw.EdgeInsets.only(top: 9),
            child: pw.Text(
              'DOCUMENTO: Solicitud estudiantes carreras tradicionales',
              style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
            ),
          ),
        ),
        pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Padding(
            padding: pw.EdgeInsets.only(top: 7),
            child: pw.Text(
              fecha,
              style: const pw.TextStyle(fontSize: 11),
            ),
          ),
        ),
        pw.Align(
          alignment: pw.Alignment.centerLeft,
          child: pw.Padding(
            padding: pw.EdgeInsets.only(top: 7),
            child: pw.Text(
              '',
              style: const pw.TextStyle(fontSize: 11),
            ),
          ),
        ),
        pw.Align(
          alignment: pw.Alignment.centerLeft,
          child: pw.Padding(
            padding: pw.EdgeInsets.only(top: 7),
            child: pw.Text(
              responsablepp,
              style: const pw.TextStyle(fontSize: 11),
            ),
          ),
        ),
        pw.Align(
          alignment: pw.Alignment.centerLeft,
          child: pw.Padding(
            padding: pw.EdgeInsets.only(top: 7),
            child: pw.Text(
              'RESPONSABLE DE PRÁCTICAS PRE PROFESIONALES DE LA CARRERA $carrera',
              style: const pw.TextStyle(fontSize: 10),
            ),
          ),
        ),
        pw.Align(
          alignment: pw.Alignment.centerLeft,
          child: pw.Padding(
            padding: pw.EdgeInsets.only(top: 7),
            child: pw.Text(
              'INSTITUTO SUPERIOR UNIVERSITARIO TECNOLÓGICO DEL AZUAY',
              style: const pw.TextStyle(fontSize: 10),
            ),
          ),
        ),
        pw.Align(
          alignment: pw.Alignment.centerLeft,
          child: pw.Padding(
            padding: pw.EdgeInsets.only(top: 7),
            child: pw.Text(
              'Su Despacho',
              style: const pw.TextStyle(fontSize: 11),
            ),
          ),
        ),
        pw.Align(
          alignment: pw.Alignment.centerLeft,
          child: pw.Padding(
            padding: pw.EdgeInsets.only(top: 7),
            child: pw.Text(
              '',
              style: const pw.TextStyle(fontSize: 11),
            ),
          ),
        ),
        pw.Align(
          alignment: pw.Alignment.centerLeft,
          child: pw.Padding(
            padding: pw.EdgeInsets.only(top: 7),
            child: pw.Text(
              '',
              style: const pw.TextStyle(fontSize: 11),
            ),
          ),
        ),
        pw.Align(
          alignment: pw.Alignment.centerLeft,
          child: pw.Padding(
            padding: pw.EdgeInsets.only(top: 7),
            child: pw.Text(
              'De mi consideración:',
              style: const pw.TextStyle(fontSize: 11),
            ),
          ),
        ),
        pw.Paragraph(
            margin: const pw.EdgeInsets.only(top: 10),
            text: bodyText1,
            style: pw.TextStyle(
              lineSpacing: 2,
              fontSize: 11,
            )),
        pw.Paragraph(
            margin: const pw.EdgeInsets.only(top: 10),
            text: bodyText2,
            style: pw.TextStyle(
              lineSpacing: 2,
              fontSize: 11,
            )),
        pw.Align(
          alignment: pw.Alignment.centerLeft,
          child: pw.Padding(
            padding: pw.EdgeInsets.only(top: 7),
            child: pw.Text(
              '',
              style: const pw.TextStyle(fontSize: 11),
            ),
          ),
        ),
        pw.Align(
          alignment: pw.Alignment.centerLeft,
          child: pw.Padding(
            padding: pw.EdgeInsets.only(top: 7),
            child: pw.Text(
              '',
              style: const pw.TextStyle(fontSize: 11),
            ),
          ),
        ),
        pw.Align(
          alignment: pw.Alignment.centerLeft,
          child: pw.Padding(
            padding: pw.EdgeInsets.only(top: 7),
            child: pw.Text(
              'Sin más que informar me despido agradeciendo de antemano su colaboración.',
              style: const pw.TextStyle(fontSize: 11),
            ),
          ),
        ),
        pw.Align(
          alignment: pw.Alignment.centerLeft,
          child: pw.Padding(
            padding: pw.EdgeInsets.only(top: 7),
            child: pw.Text(
              '',
              style: const pw.TextStyle(fontSize: 11),
            ),
          ),
        ),
        pw.Align(
          alignment: pw.Alignment.centerLeft,
          child: pw.Padding(
            padding: pw.EdgeInsets.only(top: 7),
            child: pw.Text(
              '',
              style: const pw.TextStyle(fontSize: 11),
            ),
          ),
        ),
        pw.Align(
          alignment: pw.Alignment.centerLeft,
          child: pw.Padding(
            padding: pw.EdgeInsets.only(top: 7),
            child: pw.Text(
              '',
              style: const pw.TextStyle(fontSize: 11),
            ),
          ),
        ),
        pw.Align(
          alignment: pw.Alignment.centerLeft,
          child: pw.Padding(
            padding: pw.EdgeInsets.only(top: 7),
            child: pw.Text(
              'Atentamente',
              style: const pw.TextStyle(fontSize: 11),
            ),
          ),
        ),
        pw.Align(
          alignment: pw.Alignment.centerLeft,
          child: pw.Padding(
            padding: pw.EdgeInsets.only(top: 7),
            child: pw.Text(
              '',
              style: const pw.TextStyle(fontSize: 11),
            ),
          ),
        ),
        pw.Align(
          alignment: pw.Alignment.centerLeft,
          child: pw.Padding(
            padding: pw.EdgeInsets.only(top: 7),
            child: pw.Text(
              '',
              style: const pw.TextStyle(fontSize: 11),
            ),
          ),
        ),
        pw.Align(
          alignment: pw.Alignment.centerLeft,
          child: pw.Padding(
            padding: pw.EdgeInsets.only(top: 7),
            child: pw.Text(
              '',
              style: const pw.TextStyle(fontSize: 11),
            ),
          ),
        ),
        pw.Align(
          alignment: pw.Alignment.centerLeft,
          child: pw.Padding(
            padding: pw.EdgeInsets.only(top: 7),
            child: pw.Text(
              '',
              style: const pw.TextStyle(fontSize: 11),
            ),
          ),
        ),
        pw.Align(
          alignment: pw.Alignment.centerLeft,
          child: pw.Padding(
            padding: pw.EdgeInsets.only(top: 7),
            child: pw.Text(
              '',
              style: const pw.TextStyle(fontSize: 11),
            ),
          ),
        ),
        pw.Align(
          alignment: pw.Alignment.centerLeft,
          child: pw.Padding(
            padding: pw.EdgeInsets.only(top: 7),
            child: pw.Text(
              '',
              style: const pw.TextStyle(fontSize: 11),
            ),
          ),
        ),
        pw.Align(
          alignment: pw.Alignment.centerLeft,
          child: pw.Padding(
            padding: pw.EdgeInsets.only(top: 7),
            child: pw.Text(
              '',
              style: const pw.TextStyle(fontSize: 11),
            ),
          ),
        ),
        pw.Align(
          alignment: pw.Alignment.centerLeft,
          child: pw.Padding(
            padding: pw.EdgeInsets.only(top: 7),
            child: pw.Text(
              '____________________',
              style: const pw.TextStyle(fontSize: 11),
            ),
          ),
        ),
        pw.Align(
          alignment: pw.Alignment.centerLeft,
          child: pw.Padding(
            padding: pw.EdgeInsets.only(top: 7),
            child: pw.Text(
              '',
              style: const pw.TextStyle(fontSize: 11),
            ),
          ),
        ),
        pw.Align(
          alignment: pw.Alignment.centerLeft,
          child: pw.Padding(
            padding: pw.EdgeInsets.only(top: 7),
            child: pw.Text(
              nyapellido,
              style: const pw.TextStyle(fontSize: 11),
            ),
          ),
        ),
        pw.Align(
          alignment: pw.Alignment.centerLeft,
          child: pw.Padding(
            padding: pw.EdgeInsets.only(top: 7),
            child: pw.Text(
              celular,
              style: const pw.TextStyle(fontSize: 11),
            ),
          ),
        ),
        pw.Align(
          alignment: pw.Alignment.centerLeft,
          child: pw.Padding(
            padding: pw.EdgeInsets.only(top: 7),
            child: pw.Text(
              correo,
              style: const pw.TextStyle(fontSize: 11),
            ),
          ),
        ),
      ],
    ),
  );
  return doc.save();
}

const String bodyText1 =
    "Por medio de la presente, Yo, $nombres, con número de cédula $cedula, estudiante $ciclo del periodo académico $periodo de la carrera de Tecnología Superior en Desarrollo de Software, solicito comedidamente se autorice mi postulación para realizar las 240 horas de prácticas pre profesionales en la empresa $empresa. según solicitud: $nomconvocatoria";

const String bodyText2 =
    "Acepto realizar el proceso de selección determinado por la empresa receptora y en caso de ser elegido, me comprometo a cumplir con la normativa de la empresa, presentar los requisitos solicitados por el Instituto Superior Tecnológico del Azuay como prueba de las actividades realizadas y demostrar profesionalismo, dedicación y honestidad en todo momento, dejando en alto el nombre de la institución educativa y colaborando en el fortalecimiento de la empresa receptora que me brinda la posibilidad de formarme en sus instalaciones.";

Future<pw.PageTheme> _myPageTheme(PdfPageFormat format) async {
  final logoImage = pw.MemoryImage(
    (await rootBundle.load('assets/logoista.png')).buffer.asUint8List(),
  );

  return pw.PageTheme(
      margin: const pw.EdgeInsets.symmetric(
          horizontal: 1 * PdfPageFormat.cm, vertical: 0.5 * PdfPageFormat.cm),
      textDirection: pw.TextDirection.ltr,
      orientation: pw.PageOrientation.portrait,
      buildBackground: (final context) => pw.FullPage(
          ignoreMargins: true,
          child: pw.Watermark(
              angle: 20,
              child: pw.Opacity(
                  opacity: 0.5,
                  child: pw.Image(
                      alignment: pw.Alignment.center,
                      logoImage,
                      fit: pw.BoxFit.cover)))));
}

Future<void> saveAsFile(
  final BuildContext context,
  final LayoutCallback build,
  final PdfPageFormat pageFormat,
) async {
  final bytes = await build(pageFormat);

  final appDocDir = await getApplicationDocumentsDirectory();
  final appDocPath = appDocDir.path;
  final file = File('$appDocPath/document.pdf');
  print('save as file ${file.path}...');
  await file.writeAsBytes(bytes);
  await OpenFile.open(file.path);
}

void showPrintedToast(final BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Documento Impreso Con exito')));
}

void showSharedToast(final BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Documento compartido Con exito')));
}
