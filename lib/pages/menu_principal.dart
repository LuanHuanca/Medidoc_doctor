import 'package:flutter/material.dart';
import 'package:hexagon/hexagon.dart';
import 'package:medidoc_doctor/pages/alimentaciones.dart';
import 'package:medidoc_doctor/pages/cancelarcita.dart';
import 'package:medidoc_doctor/pages/consulta_en_casa.dart';
import 'package:medidoc_doctor/pages/ficha_clinica.dart';
import 'package:medidoc_doctor/pages/navBar.dart';
import 'package:medidoc_doctor/pages/historialmedico.dart';
import 'package:medidoc_doctor/pages/receta_medica.dart';
import 'package:medidoc_doctor/pages/solicitudCita.dart';
import 'package:medidoc_doctor/pages/sos_screen.dart';
import 'package:medidoc_doctor/pages/teleconsulta.dart';
import 'package:medidoc_doctor/pages/vercitaprogramada.dart';

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
        child: Center(
          child: MyCustomButtonGrid(),
        ),
      ),
    );
  }
}

class MyCustomButtonGrid extends StatelessWidget {
  final List<Map<String, dynamic>> options = [
    {"label": "Historial médico", "image": 'assets/icons/historial_medico.png'},
    {
      "label": "Solicitud de cita",
      "image": 'assets/icons/cita_programable.png'
    },
    {
      "label": "Ver cita Programada",
      "image": 'assets/icons/ver_cita_programable.png'
    },
    {"label": "Cancelación de cita", "image": 'assets/icons/cancelar_cita.png'},
    {"label": "Consulta en casa", "image": 'assets/icons/consulta_en_casa.png'},
    {"label": "Teleconsulta", "image": 'assets/icons/teleconsulta.png'},
    {"label": "Receta Médica", "image": 'assets/icons/receta_medica.png'},
    {"label": "Ficha Médica", "image": 'assets/icons/ficha_clinica.png'},
    {"label": "Alimentación", "image": 'assets/icons/alimentacion.png'},
    {"label": "Emergencia SOS", "image": 'assets/icons/emergencia_sos.png'},
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
      } else if (item == "Ver cita Programada") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VerCitaProgramada()),
        );
      } else if (item == "Cancelación de cita") {
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
      } else if (item == "Receta Médica") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RecetaMedica()),
        );
      } else if (item == "Ficha Médica") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FichaClinica()),
        );
      } else if (item == "Alimentación") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Alimentacion()),
        );
      }
      // Agregar más opciones según sea necesario
    };
  }

  @override
  Widget build(BuildContext context) {
    return HexagonOffsetGrid.oddPointy(
      columns: 3, // Ajustar el número de columnas según sea necesario
      rows: 4, // Ajustar el número de filas según sea necesario
      buildTile: (col, row) {
        int index = row * 3 + col;
        if (index >= options.length) return HexagonWidgetBuilder();
        return HexagonWidgetBuilder(
          color: _getColorForIndex(col, row),
          padding: 4.0,
          elevation: 2.0,
          child: GestureDetector(
            onTap: _getActionForItem(context, options[index]["label"]),
            child: Center(
              child: Container(
                padding:
                    const EdgeInsets.all(8.0), // Aumentar el área de detección
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      options[index]["image"],
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      options[index]["label"],
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14, // Aumentar el tamaño de la letra
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getColorForIndex(int col, int row) {
    List<Color> colors = [
      Color(0xFF02457A),
      Color(0xFF018ABE),
      Color(0xFF97CADB),
      Color(0xFFD6E8EE)
    ];
    return colors[(col + row) % colors.length];
  }
}
