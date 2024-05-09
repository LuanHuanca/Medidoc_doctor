import 'package:flutter/material.dart';

class VerCitaProgramada extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ver cita programada',style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFF02457A),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Color(0xFF018ABE),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Fecha: 23/07/2023',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Hora: 09:30 AM',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Paciente: Eduardo Santana',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Especialidad: Oftalmología',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Médico: Dra. Elisa Duarte',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Dirección: Policlínico Hospital La Paz, Calle Bolívar Nro. 12 - Consultorio 2 Corr. 03 - Oftalmología',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            // Aquí puedes añadir más tarjetas si necesitas mostrar más citas
          ],
        ),
      ),
    );
  }
}
