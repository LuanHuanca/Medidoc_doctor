import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class CancelarCita extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cancelar cita', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF02457A),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('SolicitudCita').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Text('No hay citas disponibles');
            }

            var citaDocs = snapshot.data!.docs;

            return ListView.builder(
              itemCount: citaDocs.length,
              itemBuilder: (context, index) {
                var citaData = citaDocs[index].data() as Map<String, dynamic>;
                var citaId = citaDocs[index].id;

                return citaCard(context, citaData, citaId);
              },
            );
          },
        ),
      ),
    );
  }

  Widget citaCard(BuildContext context, Map<String, dynamic> citaData, String citaId) {
    Timestamp fechaTimestamp = citaData['fecha'];
    DateTime fechaDateTime = fechaTimestamp.toDate();
    String fechaFormatted = DateFormat('dd/MM/yyyy').format(fechaDateTime);

    return Card(
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
              'Fecha: $fechaFormatted',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              'Hora: ${citaData['horario']}',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              'Paciente: ${citaData['paciente_id_paciente']}',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              'Especialidad: ${citaData['tipocita']}',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              'Médico: ${citaData['doctor_id_doctor']}',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              'Dirección: ${citaData['direccion']}',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () => _confirmCancel(context, citaId),
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

  void _confirmCancel(BuildContext context, String citaId) {
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
                _cancelCita(citaId);
                Navigator.of(context).pop(); // Cierra el diálogo
              },
              child: const Text('Sí'),
            ),
          ],
        );
      },
    );
  }

  void _cancelCita(String citaId) async {
    await FirebaseFirestore.instance.collection('SolicitudCita').doc(citaId).delete();
    print('Cita cancelada');
  }
}
