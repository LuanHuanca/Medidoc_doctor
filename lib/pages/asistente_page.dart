import 'package:flutter/material.dart';
import 'package:medidoc_doctor/pages/navBar.dart';

class AsistentePage extends StatelessWidget {
  final String nombre = 'Camila';

  const AsistentePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Asistente Personal',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      drawer: const NavbarOptions(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Text(
              'Le damos la bienvenida Sr/a $nombre, me llamo Lia, soy su asistente personal',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.deepPurpleAccent,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              child: Image.asset('assets/images/asistente2.png'),
            ),
          ),
        ],
      ),
    );
  }
}
