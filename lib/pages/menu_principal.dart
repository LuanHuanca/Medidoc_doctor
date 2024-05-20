import 'package:flutter/material.dart';
import 'package:medidoc_doctor/colors.dart';
import 'package:medidoc_doctor/pages/cancelarcita.dart';
import 'package:medidoc_doctor/pages/consulta_en_casa.dart';
import 'package:medidoc_doctor/pages/navBar.dart';
import 'package:medidoc_doctor/pages/historialmedico.dart';
import 'package:medidoc_doctor/pages/receta_medica.dart';
import 'package:medidoc_doctor/pages/solicitudCita.dart';
import 'package:medidoc_doctor/pages/sos_screen.dart';
import 'package:medidoc_doctor/pages/teleconsulta.dart';
import 'package:medidoc_doctor/pages/vercitaprogramada.dart'; // Asegúrate de usar el path correcto

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
        backgroundColor: Color(0xFF02457A),
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
    "Solicitud de cita",
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

  MyCustomButtonGrid({Key? key}) : super(key: key);

  void Function() _getActionForItem(BuildContext context, String item) {
    return () {
      print('Se seleccionó: $item');
      if (item == "Historial médico") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HistorialMedico()),
        );
      } else if (item == "Ver cita Pogramada") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VerCitaProgramada()),
        );
      } else if (item == "Cancelacion de cita") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CancelarCita()),
        );
      } else if (item == "Teleconsulta") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Teleconsulta()),
        );
      } else if (item == "Solicitud de cita") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SolicitudCita()),
        );
      } else if (item == "Emergencia SOS") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SOSSplashScreen()),
        );
      } else if (item == "Consulta en casa") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ConsultaEnCasa()),
        );
      } else if (item == "Receta Medica") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RecetaMedica()),
        );
      }
      
      
    };
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.8,
      ),
      itemCount: options.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: _getActionForItem(context, options[index]),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: colorTerciario),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  options[index],
                  style: const TextStyle(
                    color: Colors.black,
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
