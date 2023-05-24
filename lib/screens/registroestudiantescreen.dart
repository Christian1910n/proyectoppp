import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyectoppp/model/Carrera.dart';
import 'package:proyectoppp/model/Usuario.dart';
import 'package:proyectoppp/model/estudiante.dart';
import 'package:proyectoppp/model/usuariofenix.dart';
import 'package:proyectoppp/screens/carrusel.dart';
import 'package:proyectoppp/screens/home_google_sign_in.dart';
import '../utils/url.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

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
  final TextEditingController _textController = TextEditingController();

  bool _loading = false;
  bool _showPassword = false;
  bool _habilitar = true;
  String? contra = '';
  String? rcontra = '';
  int? idcarre = 0;
  int _cicloValue = 1;

  List<Carrera> carreras = [];

  Carrera? carreraSeleccionada;

  @override
  void initState() {
    listarcarreras();
    super.initState();

    _usuario = Usuario(
        id: 0,
        cedula: '',
        nombre: '',
        apellido: '',
        correo: '',
        titulo: '',
        telefono: '',
        activo: true,
        password: '');

    _carrera = Carrera(id: 0, activo: false, idCarrera: 0, nombre: '');
    _estudiante = Estudiante(
        id: 0,
        periodo: '',
        ciclo: 0,
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
          Uri.parse('${enlace}usuariofenix/buscaralumnocedula/$encodedValue');
      try {
        final response = await http.get(url);
        final responseData = json.decode(response.body);
        final usuarioFenix = UsuarioFenix.fromJson(responseData);

        final responseBody = jsonDecode(response.body);
        if (responseBody.containsKey('Mensaje')) {
          final mensaje = responseBody['Mensaje'];
          if (mensaje ==
              'No se encontro estudiante para la cÃ©dula ${_estudiante.usuario.cedula}') {
            // ignore: use_build_context_synchronously
            dialogoerror("ESTUDIANTE NO EXISTE", context);
          } else if (mensaje == 'Ya existe el alumno') {
            // ignore: use_build_context_synchronously
            dialogoerror("USUARIO YA EXISTE", context);
          } else {}
        } else {
          String telefonos = usuarioFenix.telefono;
          List<String> telefonosList = telefonos.split(';');
          String primerTelefono = telefonosList[0];

          setState(() {
            _usuarioFenix = usuarioFenix;

            _cnombres.text = _usuarioFenix.nombres;
            _capellidos.text = _usuarioFenix.apellidos;
            _cciclo.text = '${_usuarioFenix.ciclo}';
            _ccorreo.text = _usuarioFenix.correo;
            _ctelefono.text = primerTelefono;
            _cperiodo.text = _usuarioFenix.periodo;
            idcarre = _usuarioFenix.carreraId;

            _estudiante.usuario.nombre = _usuarioFenix.nombres;
            _estudiante.usuario.apellido = _usuarioFenix.apellidos;
            _estudiante.usuario.correo = _usuarioFenix.correo;
            _estudiante.usuario.cedula = _usuarioFenix.cedula;
            _estudiante.usuario.telefono = primerTelefono;
            _estudiante.ciclo = _usuarioFenix.ciclo;
            _cicloValue = _usuarioFenix.ciclo;
            _estudiante.periodo = _usuarioFenix.periodo;
            _estudiante.idEstudiante = _usuarioFenix.alumno_docenteId;
            _habilitar = false;

            carreraSeleccionada = carreras.firstWhere(
                (carrera) => carrera.idCarrera == _usuarioFenix.carreraId);

            //_textController.text = carreraSeleccionada!.nombre;
          });
        }
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
          try {
            setState(() {
              _loading = false;
              _estudiante.carrera = carreraSeleccionada!;
            });
          } catch (error) {
            setState(() {
              _loading = false;
            });
          }
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
    print(_estudiante.carrera.id);
    print(carreraSeleccionada!.id);

    if (validatePassword(_estudiante.usuario.password!)) {
      if (contra == rcontra) {
        if (_estudiante.usuario.cedula != '' &&
            _estudiante.usuario.nombre != '' &&
            _estudiante.usuario.apellido != '' &&
            _estudiante.usuario.telefono != '' &&
            _estudiante.usuario.correo != '' &&
            _estudiante.periodo != '' &&
            contra != '' &&
            carreraSeleccionada?.nombre != '' &&
            carreraSeleccionada?.nombre != null) {
          bool confirmado = await mostrarConfirmacion(context);

          if (confirmado) {
            setState(() {
              _loading = true;
            });
            try {
              final response = await http.post(
                Uri.parse('${enlace}register'),
                headers: {
                  'Content-Type': 'application/json',
                },
                body: jsonEncode(_estudiante.toJson()),
              );
              print('holi ${response.body}');
              if (response.statusCode == 201) {
                print("hola response ");
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Usuario Registrado con Exito'),
                    duration: Duration(seconds: 3),
                  ),
                );

                // ignore: use_build_context_synchronously
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeGoogleSignIn()),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Ocurrio un error al registrar su usuario'),
                    duration: Duration(seconds: 3),
                  ),
                );
              }
            } catch (error) {
              print('aqui es $error');
            } finally {
              setState(() {
                _loading = false;
              });
            }
          }
        } else {
          dialogoerror('DATOS INCOMPLETOS', context);
        }
      } else {
        dialogoerror('CONTRASEÑAS NO COINCIDEN', context);
      }
    } else {
      dialogoerror(
          'CONTRASEÑA DEBE TENER 8 CARACTERES INCLUYENDO MAYUSCULAS, NUMEROS Y CARACTERES ESPECIALES',
          context);
    }
  }

  void listarcarreras() async {
    final url = Uri.parse('${enlace}carrera/listar');
    http.get(url).then((response) {
      final responseData = json.decode(response.body);

      for (final carreraData in responseData) {
        final carrera = Carrera.fromJson(carreraData);
        carreras.add(carrera);
      }
    }).catchError((error) {
      print(error);
    });
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
                DropdownButtonFormField<int>(
                  dropdownColor: Colors.blue,
                  value: _cicloValue,
                  items: [
                    DropdownMenuItem(
                      child: Text('1', style: TextStyle(color: Colors.white)),
                      value: 1,
                      enabled: !_habilitar,
                    ),
                    DropdownMenuItem(
                      child: Text('2', style: TextStyle(color: Colors.white)),
                      value: 2,
                      enabled: !_habilitar,
                    ),
                    DropdownMenuItem(
                      child: Text('3', style: TextStyle(color: Colors.white)),
                      value: 3,
                      enabled: !_habilitar,
                    ),
                    DropdownMenuItem(
                      child: Text('4', style: TextStyle(color: Colors.white)),
                      value: 4,
                      enabled: !_habilitar,
                    ),
                    DropdownMenuItem(
                      child: Text('5', style: TextStyle(color: Colors.white)),
                      value: 5,
                      enabled: !_habilitar,
                    ),
                    DropdownMenuItem(
                      child: Text('6', style: TextStyle(color: Colors.white)),
                      value: 6,
                      enabled: !_habilitar,
                    ),
                    DropdownMenuItem(
                      child: Text('Egresado',
                          style: TextStyle(color: Colors.white)),
                      value: 0,
                      enabled: !_habilitar,
                    ),
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Ciclo Academico',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _estudiante.ciclo = value!;
                      _cicloValue = value;
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
                      _estudiante.usuario.password = valor;
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
