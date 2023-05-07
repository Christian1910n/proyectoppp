import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyectoppp/model/Carrera.dart';
import 'package:proyectoppp/model/Usuario.dart';
import 'package:proyectoppp/model/estudiante.dart';
import 'package:proyectoppp/model/usuariofenix.dart';
import 'package:proyectoppp/screens/carrusel.dart';
import '../utils/url.dart';
import 'package:lottie/lottie.dart';

class Registroestudiantes extends StatefulWidget {
  const Registroestudiantes({super.key});

  @override
  State<Registroestudiantes> createState() => _RegistroestudiantesState();
}

class _RegistroestudiantesState extends State<Registroestudiantes> {
  late UsuarioFenix _usuarioFenix;
  late Estudiante _estudiante;
  late Usuario _usuario;
  late Carrera _carrera;
  final TextEditingController _cnombres = TextEditingController();
  final TextEditingController _capellidos = TextEditingController();
  final TextEditingController _ccorreo = TextEditingController();
  final TextEditingController _ctelefono = TextEditingController();
  final TextEditingController _cciclo = TextEditingController();
  final TextEditingController _cperiodo = TextEditingController();
  final TextEditingController _ccedula = TextEditingController();
  bool _loading = false;
  bool _showPassword = false;
  bool _habilitar = true;
  String? carreras;
  String? contra = '';
  String? rcontra = '';

  @override
  void initState() {
    super.initState();

    _usuario = Usuario(
        id: 0,
        rol: 0,
        cedula: '',
        nombre: '',
        apellido: '',
        correo: '',
        titulo: '',
        telefono: '',
        activo: true);

    _carrera = Carrera(id: 0, activo: false, idCarrera: 0, nombre: '');
    _estudiante = Estudiante(
        id: 0,
        periodo: '',
        ciclo: '',
        horasCumplidas: 0,
        prioridad: false,
        idEstudiante: 0,
        usuario: _usuario,
        carrera: _carrera);
  }

  Future<void> usuariofenix(String value) async {
    if (value.length == 10) {
      setState(() {
        _loading = true;
      });

      final encodedValue = Uri.encodeFull(value);
      final url =
          Uri.parse('${enlace}usuariofenix/buscarusuario/$encodedValue');
      try {
        final response = await http.get(url);
        final responseData = json.decode(response.body);
        final usuarioFenix = UsuarioFenix.fromJson(responseData);
        setState(() {
          _usuarioFenix = usuarioFenix;

          _cnombres.text = _usuarioFenix.nombres;
          _capellidos.text = _usuarioFenix.apellidos;
          _cciclo.text = '${_usuarioFenix.ciclo}° Ciclo';
          _ccorreo.text = _usuarioFenix.correo;
          _ctelefono.text = _usuarioFenix.telefono;
          _cperiodo.text = _usuarioFenix.periodo;

          _estudiante.usuario.nombre = _usuarioFenix.nombres;
          _estudiante.usuario.apellido = _usuarioFenix.apellidos;
          _estudiante.usuario.correo = _usuarioFenix.correo;
          _estudiante.usuario.cedula = _usuarioFenix.cedula;
          _estudiante.usuario.telefono = _usuarioFenix.telefono;
          _estudiante.ciclo = _usuarioFenix.ciclo.toString();
          _estudiante.periodo = _usuarioFenix.periodo;
          _habilitar = false;
        });
      } catch (error) {
        print('Error: $error');
        if (mounted) {
          setState(() {
            _cnombres.text = '';
            _capellidos.text = '';
            _cciclo.text = '';
            _ccorreo.text = '';
            _ctelefono.text = '';
            _cperiodo.text = '';
            _ccedula.text = value;
            _habilitar = true;
          });
        }
      } finally {
        if (mounted) {
          setState(() {
            _loading = false;
          });
        }
      }
    } else {
      setState(() {
        _cnombres.text = '';
        _capellidos.text = '';
        _cciclo.text = '';
        _ccorreo.text = '';
        _ctelefono.text = '';
        _cperiodo.text = '';
        _habilitar = true;
      });
    }
  }

  Future<void> registrarestudiante() async {
    if (contra == rcontra) {
      if (_estudiante.usuario.cedula != '' &&
          _estudiante.usuario.nombre != '' &&
          _estudiante.usuario.apellido != '' &&
          _estudiante.usuario.telefono != '' &&
          _estudiante.usuario.correo != '' &&
          _estudiante.ciclo != '' &&
          _estudiante.periodo != '' &&
          contra != '') {
        /*
        try {
          final response = await http.post(
            Uri.parse('${enlace}estudiante/crear'),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode(_estudiante.toJson()),
          );
          if (response.statusCode == 200) {
            final responseBody = jsonDecode(response.body);

            // ignore: use_build_context_synchronously
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Carrusel()),
            );
          }
        } catch (error) {
          print(error);
        } finally {
          setState(() {
            _loading = false;
          });
        }
        */
      } else {
        dialogoerror('DATOS INCOMPLETOS', context);
      }
    } else {
      dialogoerror('CONTRASEÑAS NO COINCIDEN', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Center(
        child: Stack(
          children: [
            Lottie.network(
                'https://assets6.lottiefiles.com/packages/lf20_C67qsN3hAk.json'),

            //child: Lottie.asset('assets/loading.json'),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Form(
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
                  controller: _ccedula,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Cédula',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _estudiante.usuario.cedula = value;
                    });

                    usuariofenix(value);
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _cnombres,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Nombres',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                    enabled: false,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _estudiante.usuario.nombre = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _capellidos,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Apellidos',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                  ),
                  enabled: false,
                  onChanged: (value) {
                    setState(() {
                      _estudiante.usuario.apellido = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _ccorreo,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Correo',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                  ),
                  enabled: !_habilitar,
                  onChanged: (value) {
                    setState(() {
                      _estudiante.usuario.correo = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _ctelefono,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Teléfono',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                  ),
                  enabled: !_habilitar,
                  onChanged: (value) {
                    setState(() {
                      _estudiante.usuario.telefono = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _cciclo,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Ciclo Academico',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                  ),
                  enabled: !_habilitar,
                  onChanged: (value) {
                    setState(() {
                      _estudiante.ciclo = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _cperiodo,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Periodo Academico',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                  ),
                  enabled: !_habilitar,
                  onChanged: (value) {
                    setState(() {
                      _estudiante.periodo = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: carreras,
                  decoration: const InputDecoration(
                    labelText: 'Carrera',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _estudiante.carrera.nombre = value!;
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
                  enabled: !_habilitar,
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
                      contra = valor;
                    });
                  },
                ),
                const SizedBox(height: 20),
                TextField(
                  enableInteractiveSelection: false,
                  obscureText: !_showPassword,
                  enabled: !_habilitar,
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
                      rcontra = valor;
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
                  onPressed: () {
                    registrarestudiante();
                  },
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
