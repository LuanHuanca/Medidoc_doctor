import 'package:flutter/material.dart';

enum EstadoCita { pendiente, confirmado, rechazado }

class CitaCard extends StatefulWidget {
  final String fecha;
  final String hora;
  final String paciente;
  final String especialidad;
  final String medico;
  final String direccion;
  final EstadoCita estadoInicial;
  final Function(EstadoCita nuevoEstado) onEstadoChanged;

  const CitaCard({
    Key? key,
    required this.fecha,
    required this.hora,
    required this.paciente,
    required this.especialidad,
    required this.medico,
    required this.direccion,
    required this.estadoInicial,
    required this.onEstadoChanged,
  }) : super(key: key);

  @override
  _CitaCardState createState() => _CitaCardState();
}

class _CitaCardState extends State<CitaCard> {
  late EstadoCita estadoActual;

  @override
  void initState() {
    super.initState();
    estadoActual = widget.estadoInicial;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: const Color(0xFF018ABE),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildEstadoWidget(estadoActual),
            SizedBox(height: 8),
            Text(
              'Fecha: ${widget.fecha}',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              'Hora: ${widget.hora}',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              'Paciente: ${widget.paciente}',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              'Especialidad: ${widget.especialidad}',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              'Médico: ${widget.medico}',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              'Dirección: ${widget.direccion}',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () => _cambiarEstado(EstadoCita.confirmado),
                  child: Text('Confirmar'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _cambiarEstado(EstadoCita.rechazado),
                  child: Text('Rechazar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEstadoWidget(EstadoCita estado) {
    String estadoText = '';
    Color color;
    switch (estado) {
      case EstadoCita.pendiente:
        estadoText = 'Pendiente';
        color = Colors.orange;
        break;
      case EstadoCita.confirmado:
        estadoText = 'Confirmado';
        color = Colors.green;
        break;
      case EstadoCita.rechazado:
        estadoText = 'Rechazado';
        color = Colors.red;
        break;
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        estadoText,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  void _cambiarEstado(EstadoCita nuevoEstado) {
    setState(() {
      estadoActual = nuevoEstado;
    });
    widget.onEstadoChanged(nuevoEstado);
  }
}
