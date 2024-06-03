import 'package:flutter/material.dart';
import 'package:medidoc_doctor/pages/alimentacion_paciente.dart';
import 'package:medidoc_doctor/pages/alimentacion_paciente_especifico.dart';
import 'package:medidoc_doctor/pages/navBar.dart';

class Alimentacion extends StatelessWidget {
  const Alimentacion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Alimentaciones',
          style: TextStyle(color: Colors.black),
        ),
      ),
      drawer: const NavbarOptions(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildButton(context, 'Paciente', const AlimentacionPaciente()),
            const SizedBox(height: 16),
            _buildButton(context, 'Gluten',AlimentacionPacienteEspecifico()),
            const SizedBox(height: 16),
            _buildButton(context, 'Alergias',AlimentacionPacienteEspecifico()),
            const SizedBox(height: 16),
            _buildButton(context, 'Cáncer',AlimentacionPacienteEspecifico()),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text,
      [Widget? targetScreen]) {
    return GestureDetector(
      onTap: () {
        if (targetScreen != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => targetScreen),
          );
        }
      },
      child: Card(
        color: const Color(0xFF02457A),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
