import 'package:flutter/material.dart';
import 'navBar.dart'; // Asegúrate de tener la importación correcta de tu NavBar

class SOSSplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red, // Fondo transparente
        elevation: 0, // Sin sombra
        iconTheme: IconThemeData(
          color: Colors.black, // Color del icono de menú
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Abre el drawer al presionar el ícono del menú
              },
            );
          },
        ),
      ),
      drawer: NavbarOptions(), // Aquí se añade el drawer
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
