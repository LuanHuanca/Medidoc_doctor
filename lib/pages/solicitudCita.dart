import 'package:flutter/material.dart';
import 'package:medidoc_doctor/pages/formsolicitudcita.dart';
import 'package:medidoc_doctor/pages/navBar.dart';

class SolicitudCita extends StatefulWidget {
  const SolicitudCita({Key? key}) : super(key: key);

  @override
  State<SolicitudCita> createState() => _SolicitudCitaState();
}

class _SolicitudCitaState extends State<SolicitudCita> {
  final List<String> especialidades = [
    "Alergología",
    "Cardiología",
    "Cirugía plástica",
    "Dermatología",
    "Endocrinología",
    "Fisioterapia",
    "Gastroenterología",
    "Ginecología - Obstétrica",
    "Medicina familiar y comunitaria",
    "Medicina Interna",
    "Nefrología",
    "Nutrición",
    "Neurología",
    "Odontología",
    "Otorrinolaringología",
    "Ortopedía",
    "Oftalmología",
    "Oncología",
    "Pediatría",
    "Psiquiatría",
    "Psicología",
    "Traumatología",
    "Urología",
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth ~/ 100;
    final itemWidth = screenWidth / crossAxisCount;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Solicitud de Cita',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF02457A),
      ),
      drawer: const NavbarOptions(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Solicitud de Cita',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 25,
                  childAspectRatio: itemWidth / 70,
                ),
                itemCount: especialidades.length,
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    onPressed: () {
                      final especialidad = especialidades[index];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => formularioSolicitudCita(
                                  especialidad: especialidad,
                                )),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF97CADB),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10), // Ajusta el radio del borde según lo desees
                        side: BorderSide(
                            color: Colors.black, width: 1), // Añade el borde
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          especialidades[index],
                          style: const TextStyle(
                              color: Colors.black, fontSize: 11),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
