import 'package:flutter/material.dart';
import 'package:medidoc_doctor/pages/navBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Ajustes extends StatefulWidget {
  @override
  _AjustesState createState() => _AjustesState();
}

class _AjustesState extends State<Ajustes> {
  String _selectedMethod = 'PIN';

  @override
  void initState() {
    super.initState();
    _loadSelectedMethod();
  }

  _loadSelectedMethod() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedMethod = (prefs.getString('selectedMethod') ?? 'PIN');
    });
  }

  _saveSelectedMethod(String method) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedMethod', method);
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
      drawer: const NavbarOptions(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              title: Text('Método de ingreso'),
              subtitle: Text('Selecciona tu método de ingreso preferido'),
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
              },
            ),
          ],
        ),
      ),
    );
  }
}
