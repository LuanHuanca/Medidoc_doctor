import 'package:flutter/material.dart';
import 'package:pattern_lock/pattern_lock.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Ajustes extends StatefulWidget {
  @override
  _AjustesState createState() => _AjustesState();
}

class _AjustesState extends State<Ajustes> {
  String _selectedMethod = 'Sin Contraseñas';
  TextEditingController _pinController = TextEditingController();
  String _pattern = '';

  @override
  void initState() {
    super.initState();
    _clearPin();  // Limpiar el PIN al iniciar la aplicación
    _loadSelectedMethod();
  }

  _clearPin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('pin');
    _pinController.clear();
  }

  _loadSelectedMethod() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedMethod = (prefs.getString('selectedMethod') ?? 'Sin Contraseñas');
      _pattern = prefs.getString('pattern') ?? '';
    });
  }

  _saveSelectedMethod(String method) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedMethod', method);
  }

  _savePin(String pin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('pin', pin);
  }

  _savePattern(String pattern) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('pattern', pattern);
  }

  void _setPattern(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SetPattern(),
      ),
    );
    if (result is List<int>) {
      final patternString = result.join(',');
      _savePattern(patternString);
      setState(() {
        _pattern = patternString;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ajustes',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF02457A),
      ),
      drawer: const Drawer(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              title: Text('Método de ingreso'),
              subtitle: Text('Selecciona tu método de ingreso preferido'),
            ),
            RadioListTile<String>(
              title: Text('Sin Contraseñas'),
              value: 'Sin Contraseñas',
              groupValue: _selectedMethod,
              onChanged: (value) {
                setState(() {
                  _selectedMethod = value!;
                  _saveSelectedMethod(value);
                });
              },
            ),
            RadioListTile<String>(
              title: Text('PIN'),
              value: 'PIN',
              groupValue: _selectedMethod,
              onChanged: (value) {
                setState(() {
                  _selectedMethod = value!;
                  _saveSelectedMethod(value);
                });
              },
            ),
            if (_selectedMethod == 'PIN')
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: _pinController,
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  decoration: InputDecoration(
                    labelText: 'Ingrese su PIN',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    if (value.length == 4) {
                      _savePin(value);
                    }
                  },
                ),
              ),
            RadioListTile<String>(
              title: Text('Huella dactilar'),
              value: 'Huella',
              groupValue: _selectedMethod,
              onChanged: (value) {
                setState(() {
                  _selectedMethod = value!;
                  _saveSelectedMethod(value);
                });
              },
            ),
            RadioListTile<String>(
              title: Text('Patrón'),
              value: 'Patrón',
              groupValue: _selectedMethod,
              onChanged: (value) {
                setState(() {
                  _selectedMethod = value!;
                  _saveSelectedMethod(value);
                });
                _setPattern(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SetPattern extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Establecer Patrón')),
      body: Center(
        child: PatternLock(
          selectedColor: Colors.blue,
          pointRadius: 8,
          showInput: true,
          dimension: 3,
          onInputComplete: (List<int> input) {
            Navigator.of(context).pop(input);
          },
        ),
      ),
    );
  }
}
