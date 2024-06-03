import 'package:flutter/material.dart';
import 'ingreso_hospital.dart';
import 'navBar.dart'; // Asegúrate de tener la importación correcta de tu NavBar

class FichaClinica extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ficha clínica'),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildButton(context, 'Ingreso hospitalario', IngresoHospital()),
            SizedBox(height: 16),
            _buildButton(context, 'Emergencias'),
            SizedBox(height: 16),
            _buildButton(context, 'Cirugías'),
            SizedBox(height: 16),
            _buildButton(context, 'Tratamientos'),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, [Widget? targetScreen]) {
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
        color: Color(0xFF02457A),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
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
