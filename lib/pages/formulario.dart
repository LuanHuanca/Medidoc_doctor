import 'package:flutter/material.dart';

class Formulario extends StatefulWidget {
  @override
  _FormularioState createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _motherLastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otherGenderController = TextEditingController();

  bool _isFemale = false;
  bool _isMale = false;

  void _handleGenderChange(bool? newValue, bool isFemale) {
    setState(() {
      if (isFemale) {
        _isFemale = newValue ?? false;
        if (_isFemale) {
          _isMale = false;
        }
      } else {
        _isMale = newValue ?? false;
        if (_isMale) {
          _isFemale = false;
        }
      }
    });
  }

  void _goToNextScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PdfFormulario()),
    );
  }

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
              onChanged: (newValue) {
                _handleGenderChange(newValue, true);
              },
            ),
            CheckboxListTile(
              title: Text('M'),
              value: _isMale,
              onChanged: (newValue) {
                _handleGenderChange(newValue, false);
              },
            ),
            if (!_isFemale && !_isMale) 
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
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _goToNextScreen,
              child: Text('Siguiente'),
            ),
          ],
        ),
      ),
    );
  }
}

class PdfFormulario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cargar PDF'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Título Universitario',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                //Aqui pondremos la logica para cargar los archivos pdf o sino para guardar a la base de datos
              },
              child: Text('Cargar PDF'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Pasantías',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                //Aqui pondremos la logica para cargar los archivos pdf o sino para guardar a la base de datos
              },
              child: Text('Cargar PDF'),
            ),
          ],
        ),
      ),
    );
  }
}
