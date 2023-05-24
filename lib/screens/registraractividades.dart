import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:proyectoppp/model/practica.dart';
import 'package:proyectoppp/utils/url.dart';
import 'package:http/http.dart' as http;

import '../model/semanaActividad.dart';

class RegistrarActividad extends StatefulWidget {
  final Practica practica;

  const RegistrarActividad({required this.practica});

  @override
  State<RegistrarActividad> createState() => _RegistrarActividadState();
}

class _RegistrarActividadState extends State<RegistrarActividad> {
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedEntryTime = TimeOfDay.now();
  TimeOfDay _selectedExitTime = TimeOfDay.now();
  String _description = '';
  bool _loading = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _selectEntryTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedEntryTime,
    );
    if (picked != null && picked != _selectedEntryTime) {
      setState(() {
        _selectedEntryTime = picked;
      });
    }
  }

  void _selectExitTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedExitTime,
    );
    if (picked != null && picked != _selectedExitTime) {
      setState(() {
        _selectedExitTime = picked;
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      int totalHoras =
          calcularTotalHoras(_selectedEntryTime, _selectedExitTime);

      if (totalHoras > 0) {
        setState(() {
          _loading = true;
        });
        SemanaActividad semanaActividad = SemanaActividad(
          id: 0,
          dia: _selectedDate.add(Duration(days: 1)),
          horaInicio: _selectedEntryTime,
          horaFin: _selectedExitTime,
          totalHoras: totalHoras,
          actividad: _description,
          practica: widget.practica,
        );
        try {
          String requestBody = jsonEncode(semanaActividad);
          print(requestBody);
          Map<String, String> headers = {
            'Content-Type': 'application/json',
            "Authorization": tokenacceso
          };

          var response = await http.post(
            Uri.parse('${enlace}semanaActividad/crear'),
            headers: headers,
            body: requestBody,
          );

          if (response.statusCode == 201) {
            var responseData = jsonDecode(response.body);
            print(responseData);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('La actividad se ha registrado con éxito.'),
                duration: Duration(seconds: 3),
              ),
            );
          } else {
            print('Error Post SActividad: ${response.statusCode}');
          }
        } catch (e) {
          print('Error: $e');
        } finally {
          if (mounted) {
            setState(() {
              _loading = false;
            });
          }
        }
      } else {
        dialogoerror(
            'LA HORA FINAL NO PUEDE SER MENOR A LA HORA DE INICIO', context);
      }
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
    return Theme(
      data: ThemeData(brightness: Brightness.dark),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Registro de Actividad'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                ListTile(
                  title: Text('Fecha'),
                  subtitle: Text(
                      '${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}'),
                  trailing: Icon(Icons.calendar_today),
                  onTap: _selectDate,
                ),
                ListTile(
                  title: Text('Hora de Entrada'),
                  subtitle: Text(_selectedEntryTime.format(context)),
                  trailing: Icon(Icons.access_time),
                  onTap: _selectEntryTime,
                ),
                ListTile(
                  title: Text('Hora de Salida'),
                  subtitle: Text(_selectedExitTime.format(context)),
                  trailing: Icon(Icons.access_time),
                  onTap: _selectExitTime,
                ),
                TextFormField(
                  decoration:
                      InputDecoration(labelText: 'Descripción de la Actividad'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, introduce una descripción';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _description = value!;
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Registrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
