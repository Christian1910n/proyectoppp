import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:proyectoppp/model/Usuario.dart';
import 'package:proyectoppp/screens/listaconvocatorias.dart';
import 'package:proyectoppp/utils/pdfconvocatoria.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:proyectoppp/utils/url.dart';

import '../model/convocatoria.dart';

class PdfPage extends StatefulWidget {
  final Convocatoria convocatoria;
  final Usuario usuario;
  PdfPage(this.convocatoria, this.usuario);

  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  PrintingInfo? printingInfo;
  Convocatoria? _convocatoria;
  late String bodyText1;
  late String fecha;
  late Usuario usuario;
  late String responsablepp;
  String? carrera;
  String _nroconvocatoria = '';
  String nyapellido = "";
  String celular = "";
  String correo = "";

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
                style:
                    pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
              ),
            ),
          ),
          pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Padding(
              padding: pw.EdgeInsets.only(top: 7),
              child: pw.Text(
                'Cuenca, $fecha',
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

  String bodyText2 =
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

  @override
  void initState() {
    _convocatoria = widget.convocatoria;
    usuario = widget.usuario;

    DateTime fechaactual = DateTime.now();
    fecha = DateFormat('dd \'de\' MMMM \'del\' y', 'es').format(fechaactual);

    String titulo =
        _convocatoria!.solicitudEmpresa!.convenio!.firmaInst!.usuario!.titulo!;
    String abreviatura = titulo.replaceAllMapped(
      RegExp(r'^(\w+?)\b.*$'),
      (match) => '${match.group(1)!.substring(0, 3)}.',
    );

    final String responsablepps =
        '$abreviatura ${_convocatoria!.solicitudEmpresa!.convenio!.firmaInst!.usuario!.nombre} ${_convocatoria!.solicitudEmpresa!.convenio!.firmaInst!.usuario!.apellido}';
    responsablepp = toTitleCase(responsablepps);

    String? c = _convocatoria!.solicitudEmpresa!.convenio!.carrera!.nombre;
    carrera = abreviarCarrera(c!);

    _nroconvocatoria =
        'CONVOCATORIA - $carrera -PPP-2023-00${_convocatoria!.numero}';

    print(_convocatoria!.id);

    String nombres = '${usuario.apellido} ${usuario.nombre}';

    String nfirma = '${usuario.nombre} ${usuario.apellido}';
    List<String> nombress = nfirma.split(' ');
    String primerNombre = nombress[0];
    String primerApellido = nombress[nombress.length - 1];
    String nombreCompleto = '$primerNombre $primerApellido';
    nyapellido = '$primerNombre $primerApellido';

    celular = usuario.telefono!;

    correo = usuario.correo!;

    bodyText1 =
        "Por medio de la presente, Yo, $nombres, con número de cédula ${usuario.cedula}, estudiante $ciclo del periodo académico $periodo de la carrera de Tecnología Superior en Desarrollo de Software, solicito comedidamente se autorice mi postulación para realizar las 240 horas de prácticas pre profesionales en la empresa ${_convocatoria?.solicitudEmpresa!.convenio!.empresa!.nombre} según solicitud: $_nroconvocatoria";

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _init();
  }

  Future<void> _init() async {
    final info = await Printing.info();
    setState(() {
      printingInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    pw.RichText.debug = true;
    final actions = <PdfPreviewAction>[];

    return Theme(
      data: ThemeData(
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF2196F3),
          secondary: Color(0xFFFFC107),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Solicitud Estudiantes'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: PdfPreview(
                      maxPageWidth: 700,
                      onShared: showSharedToast,
                      build: generatePdf,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
                'Firma la solicitud y subela mediante nuestra pagina web'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          listaConvocatoria(usuario: usuario)),
                );
              },
              child: const Text('Regresar al inicio'),
            ),
          ],
        ),
      ),
    );
  }
}
