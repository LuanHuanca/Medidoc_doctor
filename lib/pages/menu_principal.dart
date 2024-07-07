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
    {"label": "Historial\n médico", "image": 'assets/icons/historial_medico.png'},
    {
      "label": "Solicitud de\n cita",
      "image": 'assets/icons/cita_programable.png'
    },
    {
      "label": "Ver citas",
      "image": 'assets/icons/ver_cita_programable.png'
    },
    {"label": "Cancelar\n citas", "image": 'assets/icons/cancelar_cita.png'},
    {"label": "Consulta en\n casa", "image": 'assets/icons/consulta_en_casa.png'},
    {"label": "Teleconsulta", "image": 'assets/icons/teleconsulta.png'},
    {"label": "Receta Médica", "image": 'assets/icons/receta_medica.png'},
    {"label": "Ficha Médica", "image": 'assets/icons/ficha_clinica.png'},
    {"label": "Alimentación", "image": 'assets/icons/alimentacion.png'},
    {"label": "Emergencia\n SOS", "image": 'assets/icons/emergencia_sos.png'},
  ];

  MyCustomButtonGrid({Key? key}) : super(key: key);

  void Function() _getActionForItem(BuildContext context, String item) {
    return () {
      print('Se seleccionó: $item');
      if (item == "Historial\n médico") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HistorialMedico()),
        );
      } else if (item == "Ver citas") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VerCitaProgramada()),
        );
      } else if (item == "Cancelar\n citas") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CancelarCita()),
        );
      } else if (item == "Teleconsulta") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Teleconsulta()),
        );
      } else if (item == "Solicitud de\n cita") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SolicitudCita()),
        );
      } else if (item == "Emergencia\n SOS") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SOSSplashScreen()),
        );
      } else if (item == "Consulta en\n casa") {
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
    };
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double hexagonSize = constraints.maxWidth / 3;

        return Center(
          child: SizedBox(
            width: hexagonSize * 3,
            height: hexagonSize * 4, // Ajuste para el contenedor centrado verticalmente
            child: HexagonOffsetGrid.oddPointy(
              columns: 3,
              rows: 4,
              buildTile: (col, row) {
                int index = row * 3 + col;
                if (index >= options.length) return HexagonWidgetBuilder();
                return HexagonWidgetBuilder(
                  color: _getColorForIndex(col, row),
                  padding: 4.0,
                  elevation: 2.0,
                  cornerRadius: 8.0,
                  child: GestureDetector(
                    onTap: _getActionForItem(context, options[index]["label"]),
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            options[index]["image"],
                            width: hexagonSize * 0.4,
                            height: hexagonSize * 0.4,
                          ),
                          SizedBox(height: 1.0),
                          Text(
                            options[index]["label"],
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 9,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Color _getColorForIndex(int col, int row) {
    List<Color> colors = [
      Color(0xFF018ABE),
      Color(0xFF97CADB),
      Color(0xFFD6E8EE),
      Color(0xFFB0E0E6)
    ];
    return colors[(col + row) % colors.length];
  }
}
