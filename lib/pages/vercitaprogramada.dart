import 'package:flutter/material.dart';
import 'package:medidoc_doctor/pages/cita_card.dart';

class VerCitaProgramada extends StatefulWidget {
  const VerCitaProgramada({Key? key}) : super(key: key);

  @override
  _VerCitaProgramadaState createState() => _VerCitaProgramadaState();
}

class _VerCitaProgramadaState extends State<VerCitaProgramada> {
  List<CitaData> citas = [
    CitaData(
      id: '1',
      fecha: '23/07/2023',
      hora: '09:30 AM',
      paciente: 'Eduardo Santana',
      especialidad: 'Oftalmología',
      medico: 'Dra. Elisa Duarte',
      direccion:
          'Policlínico Hospital La Paz, Calle Bolívar Nro. 12 - Consultorio 2 Corr. 03 - Oftalmología',
      estado: EstadoCita.pendiente,
    ),
    CitaData(
      id: '2',
      fecha: '24/07/2023',
      hora: '10:00 AM',
      paciente: 'Juan Pérez',
      especialidad: 'Cardiología',
      medico: 'Dr. Carlos García',
      direccion: 'Hospital Metropolitano, Av. Libertador 1234 - Consultorio 5',
      estado: EstadoCita.pendiente,
    ),
    CitaData(
      id: '3',
      fecha: '25/07/2023',
      hora: '11:30 AM',
      paciente: 'María Rodríguez',
      especialidad: 'Pediatría',
      medico: 'Dra. Ana Martínez',
      direccion: 'Clínica Infantil, Calle Principal 567 - Consultorio 1',
      estado: EstadoCita.pendiente,
    ),
    CitaData(
      id: '4',
      fecha: '25/07/2023',
      hora: '11:30 AM',
      paciente: 'María Rodríguez',
      especialidad: 'Pediatría',
      medico: 'Dra. Ana Martínez',
      direccion: 'Clínica Infantil, Calle Principal 567 - Consultorio 1',
      estado: EstadoCita.pendiente,
    ),
    // Agrega más citas según necesites
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ver cita programada',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF02457A),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: EstadoCita.values.length,
          itemBuilder: (context, index) {
            EstadoCita estado = EstadoCita.values[index];
            List<CitaData> citasFiltradas =
                citas.where((cita) => cita.estado == estado).toList();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildEstadoHeader(estado),
                SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: citasFiltradas.length,
                  itemBuilder: (context, index) {
                    final cita = citasFiltradas[index];
                    return CitaCard(
                      key: Key(cita.id),
                      fecha: cita.fecha,
                      hora: cita.hora,
                      paciente: cita.paciente,
                      especialidad: cita.especialidad,
                      medico: cita.medico,
                      direccion: cita.direccion,
                      estadoInicial: cita.estado,
                      onEstadoChanged: (nuevoEstado) {
                        setState(() {
                          // Actualizamos el estado en la lista original
                          citas.firstWhere((c) => c.id == cita.id).estado =
                              nuevoEstado;
                        });
                      },
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildEstadoHeader(EstadoCita estado) {
    String estadoText = '';
    Color color;
    switch (estado) {
      case EstadoCita.pendiente:
        estadoText = 'Pendientes';
        color = Colors.orange;
        break;
      case EstadoCita.confirmado:
        estadoText = 'Confirmados';
        color = Colors.green;
        break;
      case EstadoCita.rechazado:
        estadoText = 'Rechazados';
        color = Colors.red;
        break;
    }
    return Padding(
      padding: EdgeInsets.only(left: 12, bottom: 8),
      child: Text(
        estadoText,
        style:
            TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
      ),
    );
  }
}

class CitaData {
  final String id;
  final String fecha;
  final String hora;
  final String paciente;
  final String especialidad;
  final String medico;
  final String direccion;
  EstadoCita estado;

  CitaData({
    required this.id,
    required this.fecha,
    required this.hora,
    required this.paciente,
    required this.especialidad,
    required this.medico,
    required this.direccion,
    required this.estado,
  });
}
