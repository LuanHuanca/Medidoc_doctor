import 'package:flutter/material.dart';

class HistorialMedico extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial médico',style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFF02457A),
        
      ),
      body: ListView.builder(
        itemCount: 12, // Número de años a mostrar
        itemBuilder: (context, index) {
          int year = 2023 - index; // Calcula el año correspondiente
          return Card(
            color: Color(0xFF018ABE), // Color de fondo de cada tarjeta
            child: ListTile(
              title: Text(
                '$year',
                style: TextStyle(color: Colors.white), // Color del texto
              ),
              onTap: () {
                // Aquí puedes añadir la acción al presionar cada elemento
                print('Seleccionado el año $year');
              },
            ),
          );
        },
      ),
    );
  }
}
