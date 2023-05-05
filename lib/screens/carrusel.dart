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
    'https://www.eluniverso.com/resizer/a7RzV9cpgq3r0Pxpo__CtrcH2Wk=/arc-anglerfish-arc2-prod-eluniverso/public/NUNM6L7XP26ZH2ZX2UUP7C5JIA.jpg',
    'https://www.semana.com/resizer/fTo3TLRNuIi_JIOiSoLBhqVz1yw=/1920x0/smart/filters:format(jpg):quality(80)/cloudfront-us-east-1.images.arcpublishing.com/semana/HGVAZXW4YNG2FJIETGXXGBVEPE.JPG',
    'https://pbs.twimg.com/media/E4l_tzxWUAgU1kw.jpg:large',
    'https://hipocritalector.com/wp-content/uploads/2022/12/cristiano-ronaldo.jpg'
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  height: 5,
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Container(
                  height: 5,
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  height: 5,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(80.0),
            child: Text(
              "Visita la web para lograr mucho mas",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'papyrus',
                fontSize: 35,
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
              height: 260,
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.easeInBack,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 1000),
              viewportFraction: 0.6,
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(12.0),
              textStyle: const TextStyle(fontSize: 12, fontFamily: 'papyrus'),
              backgroundColor: const Color.fromARGB(255, 0, 84, 153),
            ),
            onPressed: () => abrirRegistroEstudiantes(context),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.accessibility, size: 18),
                SizedBox(width: 5),
                Text('REGISTRARSE'),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              textStyle: const TextStyle(fontSize: 12, fontFamily: 'papyrus'),
              backgroundColor: const Color.fromARGB(255, 0, 84, 153),
            ),
            onPressed: abrirlogin,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.login, size: 15),
                SizedBox(width: 5),
                Text('Iniciar Sesión'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
