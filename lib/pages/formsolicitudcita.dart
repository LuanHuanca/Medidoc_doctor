import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medidoc_doctor/pages/menu_principal.dart';

class formularioSolicitudCita extends StatefulWidget {
  final String especialidad;

  const formularioSolicitudCita({Key? key, required this.especialidad})
      : super(key: key);

  @override
  State<formularioSolicitudCita> createState() =>
      _formularioSolicitudCitaState();
}

class _formularioSolicitudCitaState extends State<formularioSolicitudCita> {
  final TextEditingController _fechaController = TextEditingController();
  final TextEditingController _horaController = TextEditingController();
  final TextEditingController _pacienteController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final String medico = 'Médico 1'; // Valor del campo doctor_id_doctor
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Formulario de cita',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF02457A),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            TextFormField(
              controller: TextEditingController(text: widget.especialidad),
              enabled: false,
              decoration: const InputDecoration(
                labelText: "Especialidad",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15.0),
            TextFormField(
              controller: _fechaController,
              readOnly: true,
              onTap: () => _selectDate(context),
              decoration: const InputDecoration(
                labelText: "Fecha",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15.0),
            TextFormField(
              controller: _horaController,
              readOnly: true,
              onTap: () => _selectTime(context),
              decoration: const InputDecoration(
                labelText: "Hora",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15.0),
            TextFormField(
              controller: _pacienteController,
              decoration: const InputDecoration(
                labelText: "Paciente",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15.0),
            TextFormField(
              controller: TextEditingController(text: medico),
              enabled: false,
              decoration: const InputDecoration(
                labelText: "Médico",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15.0),
            TextFormField(
              controller: _direccionController,
              decoration: const InputDecoration(
                labelText: "Dirección",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => _confirmCita(context),
              child: Text('Agendar Cita'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF018ABE),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _fechaController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _horaController.text = pickedTime.format(context);
      });
    }
  }

  void _confirmCita(BuildContext context) async {
    if (_validateForm()) {
      bool confirm = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirmar cita'),
            content:
                const Text('¿Estás seguro de que quieres agendar esta cita?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('Sí'),
              ),
            ],
          );
        },
      );

      if (confirm) {
        _saveCitaToFirestore();
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text(
                'Por favor, completa todos los campos correctamente.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Aceptar'),
              ),
            ],
          );
        },
      );
    }
  }

  bool _validateForm() {
    return _fechaController.text.isNotEmpty &&
        _horaController.text.isNotEmpty &&
        _pacienteController.text.isNotEmpty &&
        _direccionController.text.isNotEmpty;
  }

  Future<void> _saveCitaToFirestore() async {
    final cita = {
      'direccion': _direccionController.text,
      'doctor_id_doctor': medico,
      'estado': 'pendiente',
      'fecha': DateTime.now(),
      'horario': _horaController.text,
      'id_cita': 7, // Ajusta este valor según corresponda
      'id_paciente': _pacienteController.text,
      'tipocita': widget.especialidad,
    };

    try {
      await FirebaseFirestore.instance.collection('SolicitudCita').add(cita);
      print('Cita agendada');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MenuPrincipal()),
      );
    } catch (e) {
      print('Error al agendar cita: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text(
                'Hubo un problema al agendar la cita. Por favor, inténtalo de nuevo.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Aceptar'),
              ),
            ],
          );
        },
      );
    }
  }
}
