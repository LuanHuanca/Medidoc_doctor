import 'package:flutter/material.dart';
//import 'package:medidoc_doctor/pages/chatbot_screen.dart';
import 'package:medidoc_doctor/pages/navBar.dart';
import 'package:url_launcher/url_launcher.dart';

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
        backgroundColor: Color(0xFF02457A),
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
                color: Color(0xFF02457A),
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              // Lógica para repetir el tutorial
            },
            child: Text('Repetir Tutorial'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Color(0xFF02457A),
              padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
              textStyle: TextStyle(fontSize: 18.0),
            ),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () async {
              const url = 'https://character.ai/chat/JG1FnD108airSy3MIy3PoUOdMhtKI9VB9agsdFWWBLc';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            child: Text('Doctor IA'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Color(0xFF02457A),
              padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
              textStyle: TextStyle(fontSize: 18.0),
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
