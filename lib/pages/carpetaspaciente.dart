import 'package:flutter/material.dart';
import 'package:medidoc_doctor/colors.dart';

class CarpetasPaciente extends StatefulWidget {
  final Map<String, dynamic> user;

  const CarpetasPaciente({super.key, required this.user});

  @override
  _CarpetasPacienteState createState() => _CarpetasPacienteState();
}

class _CarpetasPacienteState extends State<CarpetasPaciente> {
  List<Map<String, String>> archivos = [
    {"nombre": "Radiografias"},
    {"nombre": "Alergias"},
    {"nombre": "Operaciones"},
    {"nombre": "Biografia"},
    {"nombre": "Resultados de pruebas"},
    {"nombre": "Examenes fisicos"},
    {"nombre": "Informacion de urgencia"},
    {"nombre": "Ordenes medicas cursadas"},
    {"nombre": "Historial RCP"},
    {"nombre": "Hoja de interconsulta"},
    {"nombre": "Ejercicio fisioterapeutico"},
  ];

  void _showAddFolderDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String folderName = '';
        return AlertDialog(
          title: const Text('Añadir Nueva Carpeta'),
          content: TextField(
            decoration:
                const InputDecoration(labelText: 'Nombre de la carpeta'),
            onChanged: (value) {
              folderName = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (folderName.isNotEmpty) {
                  setState(() {
                    archivos.add({"nombre": folderName});
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Añadir'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Archivos del paciente',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: colorPrimario,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Paciente: ${widget.user['nombre']}',
              style: const TextStyle(fontSize: 24),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 24.0, // Espacio horizontal
                mainAxisSpacing: 30.0, // Espacio vertical
              ),
              itemCount: archivos.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                  },
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Icon(
                        Icons.snippet_folder_rounded,
                        size: 64.0, // Tamaño del icono
                        color: colorSecundario,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        archivos[index]["nombre"]!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddFolderDialog,
        backgroundColor: colorSecundario,
        child: const Icon(Icons.add),
      ),
    );
  }
}
