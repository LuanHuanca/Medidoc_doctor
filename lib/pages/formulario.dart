import 'package:flutter/material.dart';

class Formulario extends StatelessWidget {
  // Controladores para los campos de texto
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _motherLastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otherGenderController = TextEditingController();

  // Variables para manejar el estado de los checkboxes de género
  bool _isFemale = false;
  bool _isMale = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              controller: _fullNameController,
              decoration: InputDecoration(
                labelText: 'Nombre completo',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _lastNameController,
              decoration: InputDecoration(
                labelText: 'Apellido paterno',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _motherLastNameController,
              decoration: InputDecoration(
                labelText: 'Apellido materno',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            Text('Género:'),
            CheckboxListTile(
              title: Text('F'),
              value: _isFemale,
              onChanged: (bool? value) {
                // Añadir lógica para manejar cambios y asegurarse de que solo un checkbox pueda estar seleccionado a la vez
              },
            ),
            CheckboxListTile(
              title: Text('M'),
              value: _isMale,
              onChanged: (bool? value) {
                // Añadir lógica para manejar cambios y asegurarse de que solo un checkbox pueda estar seleccionado a la vez
              },
            ),
            TextFormField(
              controller: _otherGenderController,
              decoration: InputDecoration(
                labelText: 'Otro (especificar)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Correo',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            // Aquí puedes continuar con otros campos y botones según necesites
          ],
        ),
      ),
    );
  }
}
