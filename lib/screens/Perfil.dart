import 'package:flutter/material.dart';
import 'package:proyectoppp/model/Usuario.dart';
import 'package:proyectoppp/utils/url.dart';

class Perfil extends StatefulWidget {
  final Usuario usuario;
  final String rol;

  const Perfil({required this.usuario, required this.rol});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  late Usuario usuario;

  @override
  void initState() {
    usuario = widget.usuario;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(brightness: Brightness.dark),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Perfil de Usuario'),
        ),
        drawer: MenuEstudiante(usuario, context, widget.rol),
        body: Container(
          color: Colors.grey[900],
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text(
                'MI PERFIL',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              const SizedBox(height: 8),
              const Divider(color: Colors.white),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.credit_card, color: Colors.white),
                title: Text('Cédula: ${usuario.cedula}',
                    style: const TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 8),
              ListTile(
                leading: const Icon(Icons.person, color: Colors.white),
                title: Text('Nombres: ${usuario.nombre}',
                    style: const TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 8),
              ListTile(
                leading: const Icon(Icons.person, color: Colors.white),
                title: Text('Apellidos: ${usuario.apellido}',
                    style: const TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 8),
              ListTile(
                leading: const Icon(Icons.email, color: Colors.white),
                title: Text('Correo: ${usuario.correo}',
                    style: const TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 8),
              ListTile(
                leading: const Icon(Icons.phone, color: Colors.white),
                title: Text('Teléfono: ${usuario.telefono}',
                    style: const TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
