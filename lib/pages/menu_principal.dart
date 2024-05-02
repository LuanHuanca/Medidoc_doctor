import 'dart:math';
import 'package:flutter/material.dart';
import 'package:medidoc_doctor/pages/navBar.dart';

class MenuPrincipal extends StatelessWidget {
  const MenuPrincipal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Menu',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      drawer: const NavbarOptions(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: MyCustomButtonGrid(),
            ),
          ],
        ),
      ),
    );
  }
}

class MyCustomButtonGrid extends StatelessWidget {
  final List<String> options = [
    "Historial médico",
    "Ver cita Pogramada",
    "Cancelacion de cita",
    "Consulta en casa",
    "Cuestionarios medicos",
    "Teleconsulta",
    "Tutoriales de primeros auxilios",
    "Emergencia SOS",
    "RPO",
    "Receta Medica",
    "Ficha Medica"
  ];

  MyCustomButtonGrid({Key? key});

  void Function() _getActionForItem(String item) {
    return () {
      print('Se seleccionó: $item');
    };
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 0.7,
      ),
      itemCount: options.length,
      itemBuilder: (context, index) {
        final random = Random();
        final imageUrl = 'https://source.unsplash.com/featured/?medicine,hospital&${random.nextInt(100)}';

        return GestureDetector(
          onTap: _getActionForItem(options[index]),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  options[index],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
