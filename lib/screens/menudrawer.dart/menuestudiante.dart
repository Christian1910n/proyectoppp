import 'package:flutter/material.dart';

class MenuEstudiante extends StatefulWidget {
  const MenuEstudiante({super.key});

  @override
  State<MenuEstudiante> createState() => _MenuEstudianteState();
}

class _MenuEstudianteState extends State<MenuEstudiante> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ESTUDIANTE',
          style: TextStyle(
            color: Colors.blue,
            fontFamily: 'papyrus',
            fontSize: 15,
          ),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.blue),
      ),
      backgroundColor: Colors.black,
      drawer: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Drawer(
          backgroundColor: Colors.black,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 48, 4, 56),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 80.0,
                      child: Image.network(
                        'http://dev2020.tecazuay.edu.ec/wp-content/uploads/2022/11/cropped-LOGO-RECTANGULAR_SIN-FONDO.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Text(
                        "CHRISTIAN GARAICOA",
                        style: TextStyle(
                          color: Colors.blue,
                          fontFamily: 'cursive',
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: const Text(
                  'CONVOCATORIAS',
                  style: TextStyle(
                    color: Colors.blue,
                    fontFamily: 'papyrus',
                    fontSize: 15,
                  ),
                ),
                leading: const Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
                tileColor: Colors.black,
                onTap: () {
                  // Handle onTap event
                },
              ),
              ListTile(
                title: const Text(
                  'MI PERFIL',
                  style: TextStyle(
                    color: Colors.blue,
                    fontFamily: 'papyrus',
                    fontSize: 15,
                  ),
                ),
                leading: const Icon(
                  Icons.account_circle,
                  color: Colors.white,
                ),
                tileColor: Colors.black,
                onTap: () {
                  // Handle onTap event
                },
              ),
            ],
          ),
        ),
      ),
      body: Container(),
    );
  }
}
