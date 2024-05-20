import 'package:flutter/material.dart';

class SOSSplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red, // Fondo rojo
        child: Center(
          child: Text(
            'SOS',
            style: TextStyle(
              fontSize: 72, // Tamaño de fuente grande
              color: Colors.white, // Texto blanco
              fontWeight: FontWeight.bold, // Texto en negrita
            ),
          ),
        ),
      ),
    );
  }
}
