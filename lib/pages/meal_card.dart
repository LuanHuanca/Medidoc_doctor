import 'package:flutter/material.dart';

class MealCard extends StatelessWidget {
  final String title;
  final List<String> options;
  final Function(String, List<String>) onEdit;
  final VoidCallback onDelete;

  MealCard({
    required this.title,
    required this.options,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showEditDialog(context, title, options, onEdit, onDelete),
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
                ...options.map((option) => Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    option,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

void _showEditDialog(
    BuildContext context,
    String currentTitle,
    List<String> currentOptions,
    Function(String, List<String>) onEdit,
    VoidCallback onDelete,
  ) {
    final titleController = TextEditingController(text: currentTitle);
    final optionsController = TextEditingController(text: currentOptions.join('\n'));

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar Sección'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Título'),
                ),
                TextField(
                  controller: optionsController,
                  decoration: InputDecoration(labelText: 'Opciones'),
                  maxLines: null,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Guardar'),
              onPressed: () {
                onEdit(titleController.text, optionsController.text.split('\n'));
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
