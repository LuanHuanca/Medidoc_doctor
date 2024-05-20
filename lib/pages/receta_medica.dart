import 'package:flutter/material.dart';

class RecetaMedica extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receta médica'),
        backgroundColor: Color(0xFF02457A),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              color: Color(0xFF02457A),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nombre:',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Nacimiento:',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Teléfono:',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Dirección:',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: Text(
                      'PRESCRIPCIÓN:',
                      style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    height: 200,
                    color: Colors.white,
                    child: Center(
                      child: Text(
                        'Contenido de la prescripción',
                        style: TextStyle(color: Color(0xFF02457A)),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Fecha:',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Text(
                        'Firma:',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Acción al enviar la receta
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF02457A),
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: Text('Enviar al paciente y farmacias'),
            ),
          ],
        ),
      ),
    );
  }
}
