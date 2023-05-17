import 'package:flutter/material.dart';

class RegistrarActividad extends StatefulWidget {
  const RegistrarActividad({super.key});

  @override
  State<RegistrarActividad> createState() => _RegistrarActividadState();
}

class Activity {
  DateTime date;
  TimeOfDay entryTime;
  TimeOfDay exitTime;
  String description;

  Activity({
    required this.date,
    required this.entryTime,
    required this.exitTime,
    required this.description,
  });
}

class _RegistrarActividadState extends State<RegistrarActividad> {
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedEntryTime = TimeOfDay.now();
  TimeOfDay _selectedExitTime = TimeOfDay.now();
  String _description = '';

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

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Create an instance of Activity using the form data
      Activity newActivity = Activity(
        date: _selectedDate,
        entryTime: _selectedEntryTime,
        exitTime: _selectedExitTime,
        description: _description,
      );

      // Process the new activity (e.g., save to a database)
      // ...

      // Show a success message or navigate to another screen
      // ...
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(brightness: Brightness.dark),
      child: Scaffold(
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
