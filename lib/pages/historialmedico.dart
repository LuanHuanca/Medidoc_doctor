import 'package:flutter/material.dart';
import 'package:medidoc_doctor/pages/historialgeneral.dart';

class HistorialMedico extends StatelessWidget {
  const HistorialMedico({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Historial médico',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF02457A),
      ),
      body: ListView.builder(
        itemCount: 12, // Número de años a mostrar
        itemBuilder: (context, index) {
          int year = 2023 - index; // Calcula el año correspondiente
          return Card(
            color: const Color(0xFF018ABE), // Color de fondo de cada tarjeta
            child: ListTile(
              title: Text(
                '$year',
                style: const TextStyle(color: Colors.white), // Color del texto
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HistorialGeneral(),));
              },
            ),
          );
        },
      ),
    );
  }
}
