import 'package:flutter/material.dart';

class CancelarCita extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cancelar cita'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: <Widget>[
            citaCard(context),
            // Puedes añadir más tarjetas si tienes múltiples citas
          ],
        ),
      ),
    );
  }

  Widget citaCard(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Colors.purple[300],
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
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () => _confirmCancel(context),
                child: Text(
                  'Cancelar Cita',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _confirmCancel(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar cancelación'),
          content: const Text('¿Estás seguro de que quieres cancelar esta cita?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                // Aquí podrías añadir la lógica para eliminar la cita de la base de datos o el servicio
                print('Cita cancelada');
                Navigator.of(context).pop(); // Cierra el diálogo
              },
              child: const Text('Sí'),
            ),
          ],
        );
      },
    );
  }
}
