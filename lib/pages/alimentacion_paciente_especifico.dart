import 'package:flutter/material.dart';

import 'meal_card.dart';

class AlimentacionPacienteEspecifico extends StatefulWidget {
  const AlimentacionPacienteEspecifico({Key? key}) : super(key: key);

  @override
  _AlimentacionPacienteEspecificoState createState() =>
      _AlimentacionPacienteEspecificoState();
}

class _AlimentacionPacienteEspecificoState
    extends State<AlimentacionPacienteEspecifico> {
  List<Map<String, String>> sections = [
    {'title': 'Ingesta Calórica Diaria Recomendada', 'content': '1800 kcal'},
    {
      'title': 'Distribución de Macronutrientes',
      'content': 'Proteínas: 90g/día\nCarbohidratos: 200g/día\nGrasas: 60g/día'
    },
    {'title': 'Hidratación', 'content': 'Agua: 2 litros diarios'},
    {
      'title': 'Suplementos Recomendados',
      'content': 'Multivitamínico diario (según recomendación del médico)'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plan de Alimentación'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...sections.map((section) => _buildCard(
                    title: section['title']!,
                    content: section['content']!,
                    onEdit: (newTitle, newContent) {
                      setState(() {
                        section['title'] = newTitle;
                        section['content'] = newContent;
                      });
                    },
                    onDelete: () {
                      setState(() {
                        sections.remove(section);
                      });
                    },
                  )),
              _buildSectionTitle(title: 'Plan de comida detallado'),
              MealCard(
                title: 'Desayuno',
                options: [
                  'Opción 1: Avena con frutas y nueces',
                  'Opción 2: Tostada integral con aguacate y huevo',
                ],
                onEdit: (newTitle, newOptions) {
                  // Handle edit functionality
                },
                onDelete: () {
                  // Handle delete functionality
                },
              ),
              MealCard(
                title: 'Almuerzo',
                options: [
                  'Opción 1: Ensalada de quinoa y pollo',
                  'Opción 2: Sopa de lentejas y ensalada verde',
                ],
                onEdit: (newTitle, newOptions) {
                  // Handle edit functionality
                },
                onDelete: () {
                  // Handle delete functionality
                },
              ),
              MealCard(
                title: 'Cena',
                options: [
                  'Opción 1: Salmón al horno con vegetales',
                  'Opción 2: Pechuga de pollo con espinacas salteadas',
                ],
                onEdit: (newTitle, newOptions) {
                  // Handle edit functionality
                },
                onDelete: () {
                  // Handle delete functionality
                },
              ),
              MealCard(
                title: 'Meriendas',
                options: [
                  'Opción 1: Yogur griego con frutas',
                  'Opción 2: Palitos de zanahoria y hummus',
                ],
                onEdit: (newTitle, newOptions) {
                  // Handle edit functionality
                },
                onDelete: () {
                  // Handle delete functionality
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddDialog(context);
        },
        child: Icon(Icons.add),
        tooltip: 'Añadir sección',
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required String content,
    required Function(String, String) onEdit,
    required VoidCallback onDelete,
  }) {
    return GestureDetector(
      onTap: () => _showEditDialog(context, title, content, onEdit, onDelete),
      child: Container(
        width: double.infinity,
        child: Card(
          margin: EdgeInsets.only(bottom: 16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  content,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle({required String title}) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final titleController = TextEditingController();
    final contentController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Añadir Nueva Sección'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Título'),
              ),
              TextField(
                controller: contentController,
                decoration: InputDecoration(labelText: 'Contenido'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Añadir'),
              onPressed: () {
                setState(() {
                  sections.add({
                    'title': titleController.text,
                    'content': contentController.text,
                  });
                });
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, String currentTitle, String currentContent, Function(String, String) onEdit, VoidCallback onDelete) {
    final titleController = TextEditingController(text: currentTitle);
    final contentController = TextEditingController(text: currentContent);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar Sección'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Título'),
              ),
              TextField(
                controller: contentController,
                decoration: InputDecoration(labelText: 'Contenido'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Guardar'),
              onPressed: () {
                onEdit(titleController.text, contentController.text);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Eliminar'),
              onPressed: () {
                onDelete();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
