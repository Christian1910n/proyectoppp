import 'package:flutter/material.dart';

class Registroestudiantes extends StatefulWidget {
  const Registroestudiantes({super.key});

  @override
  State<Registroestudiantes> createState() => _RegistroestudiantesState();
}

class _RegistroestudiantesState extends State<Registroestudiantes> {
  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  String? _cedula;
  String? _nombres;
  String? _apellidos;
  String? _correo;
  String? _telefono;
  String? _ciclo;
  String? _periodoAcademico;
  String? _carrera;
  String? _contra;
  String? _rcontra;
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Text(
                    "REGISTRO DE USUARIO",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'papyrus',
                      fontSize: 15,
                    ),
                  ),
                ),
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Cédula',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _cedula = value;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Nombres',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _nombres = value;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Apellidos',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _apellidos = value;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Correo',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _correo = value;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Teléfono',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _telefono = value;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Ciclo Academico',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _ciclo = value;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Periodo Academico',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _periodoAcademico = value;
                  },
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: _carrera,
                  decoration: const InputDecoration(
                    labelText: 'Carrera',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _carrera = value!;
                    });
                  },
                  items: [
                    const DropdownMenuItem(
                      value: 'Carrera 1',
                      child: Text('Carrera 1'),
                    ),
                    const DropdownMenuItem(
                      value: 'Carrera 2',
                      child: Text('Carrera 2'),
                    ),
                    const DropdownMenuItem(
                      value: 'Carrera 3',
                      child: Text('Carrera 3'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextField(
                  enableInteractiveSelection: false,
                  obscureText: !_showPassword,
                  decoration: InputDecoration(
                      labelText: 'Contraseña',
                      suffixIcon: IconButton(
                        icon: _showPassword
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.0))),
                  style: const TextStyle(color: Colors.white),
                  onChanged: (valor) {
                    setState(() {
                      _contra = valor;
                    });
                  },
                ),
                const SizedBox(height: 20),
                TextField(
                  enableInteractiveSelection: false,
                  obscureText: !_showPassword,
                  decoration: InputDecoration(
                      labelText: 'Repetir Contraseña',
                      suffixIcon: IconButton(
                        icon: _showPassword
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.0))),
                  style: const TextStyle(color: Colors.white),
                  onChanged: (valor) {
                    setState(() {
                      _rcontra = valor;
                    });
                  },
                ),
                ElevatedButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    textStyle:
                        const TextStyle(fontSize: 12, fontFamily: 'papyrus'),
                    backgroundColor: const Color.fromARGB(255, 0, 84, 153),
                  ),
                  onPressed: () {},
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.login, size: 15),
                      SizedBox(width: 5),
                      Text('REGISTRAR'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
