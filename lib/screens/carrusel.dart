import 'dart:io';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:proyectoppp/screens/home_google_sign_in.dart';
import 'package:proyectoppp/screens/registroestudiantescreen.dart';

class Carrusel extends StatefulWidget {
  const Carrusel({super.key});

  @override
  State<Carrusel> createState() => _CarruselState();
}

class _CarruselState extends State<Carrusel> {
  Future<ByteData> loadFont(String fontFilename) async {
    return await rootBundle.load('assets/$fontFilename');
  }

  final List<String> images = [
    'https://firebasestorage.googleapis.com/v0/b/practicas-77c99.appspot.com/o/mision.png?alt=media&token=9232ba2f-579d-47fe-9680-bf5f7f4b0c39',
    'https://firebasestorage.googleapis.com/v0/b/practicas-77c99.appspot.com/o/vision.png?alt=media&token=ffff1950-73ab-4306-aea1-4df4c5f64444',
    'https://firebasestorage.googleapis.com/v0/b/practicas-77c99.appspot.com/o/principios.png?alt=media&token=57fffc25-9633-43ac-bafd-c4adae070e3f',
  ];

  abrirlogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeGoogleSignIn()),
    );
  }

  void abrirRegistroEstudiantes(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Registroestudiantes()),
    );
  }

  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Verificar si se ha presionado el botón de retroceso anteriormente
        if (currentBackPressTime == null ||
            DateTime.now().difference(currentBackPressTime!) >
                Duration(seconds: 2)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Presione otra vez para salir'),
              duration: Duration(seconds: 3),
            ),
          );
          currentBackPressTime = DateTime.now();
          return false;
        }
        exit(0);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 3,
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Container(
                    height: 3,
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 3,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(40.0),
              child: Text(
                "Visita la web para lograr mucho mas",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'papyrus',
                  fontSize: 30,
                ),
              ),
            ),
            CarouselSlider.builder(
              itemCount: images.length,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                final imageUrl = images[index];
                return Image.network(imageUrl, fit: BoxFit.cover);
              },
              options: CarouselOptions(
                height: 450,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 4 / 1,
                autoPlayCurve: Curves.easeInBack,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 1000),
                viewportFraction: 0.9,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(12.0),
                textStyle: const TextStyle(fontSize: 15, fontFamily: 'Arial'),
                backgroundColor: const Color.fromARGB(255, 0, 84, 153),
              ),
              onPressed: () => abrirRegistroEstudiantes(context),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.accessibility, size: 20),
                  SizedBox(width: 5),
                  Text('Registrarse'),
                ],
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                textStyle: const TextStyle(fontSize: 15, fontFamily: 'Arial'),
                backgroundColor: const Color.fromARGB(255, 0, 84, 153),
              ),
              onPressed: abrirlogin,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.login, size: 18),
                  SizedBox(width: 5),
                  Text('Iniciar Sesión'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
