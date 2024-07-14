import 'package:flutter/material.dart';
import 'package:pattern_lock/pattern_lock.dart';
import 'package:medidoc_doctor/logica_Autorizacion.dart';
import 'package:medidoc_doctor/pages/menu_principal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BioPag extends StatefulWidget {
  const BioPag({Key? key}) : super(key: key);

  @override
  State<BioPag> createState() => _BioPagState();
}

class _BioPagState extends State<BioPag> {
  bool autorizacion = false;
  String _selectedMethod = 'PIN';
  TextEditingController _pinController = TextEditingController();
  String _pattern = '';

  @override
  void initState() {
    super.initState();
    _loadSelectedMethod();
  }

  _loadSelectedMethod() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedMethod = (prefs.getString('selectedMethod') ?? 'Sin Contraseñas');
      _pattern = prefs.getString('pattern') ?? '';
    });
    if (_selectedMethod == 'Huella') {
      _autenticarHuella();
    } else if (_selectedMethod == 'PIN') {
      _autenticarPIN();
    } else if (_selectedMethod == 'Patrón') {
      _autenticarPatron();
    } else if (_selectedMethod == 'Sin Contraseñas') {
      _autenticarSinContrasenas();
    }
  }

  Future<void> _autenticarHuella() async {
    final autenticacion = await LAutorizacion.autenticar();
    setState(() {
      autorizacion = autenticacion;
      if (autorizacion) {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => MenuPrincipal()));
      }
    });
  }

  Future<void> _autenticarPIN() async {
    String? pin = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Ingrese su PIN'),
        content: TextField(
          controller: _pinController,
          keyboardType: TextInputType.number,
          maxLength: 4,
          decoration: InputDecoration(
            labelText: 'PIN',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(_pinController.text);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );

    if (pin == _pinController.text) {
      setState(() {
        autorizacion = true;
        if (autorizacion) {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => MenuPrincipal()));
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PIN incorrecto')),
      );
    }
    _pinController.clear();  // Limpiar el PIN después de la autenticación
  }

  Future<void> _autenticarPatron() async {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(title: Text('Ingrese su patrón')),
        body: PatternLock(
          selectedColor: Colors.blue,
          pointRadius: 8,
          showInput: true,
          dimension: 3,
          onInputComplete: (List<int> input) {
            final inputPattern = input.join(',');
            if (inputPattern == _pattern) {
              setState(() {
                autorizacion = true;
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => MenuPrincipal()));
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Patrón incorrecto')),
              );
            }
          },
        ),
      ),
    ));
  }

  Future<void> _autenticarSinContrasenas() async {
    setState(() {
      autorizacion = true;
      if (autorizacion) {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => MenuPrincipal()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro Biometrico'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.deepPurple[200],
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!autorizacion) ...[
                if (_selectedMethod == 'Huella') ...[
                  Icon(
                    Icons.fingerprint,
                    size: 120,
                    color: Colors.black,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Ingresar con huella',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ],
                if (_selectedMethod == 'PIN') ...[
                  Icon(
                    Icons.lock,
                    size: 120,
                    color: Colors.black,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Ingresar con PIN',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ],
                if (_selectedMethod == 'Patrón') ...[
                  Icon(
                    Icons.pattern,
                    size: 120,
                    color: Colors.black,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Ingresar con patrón',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ],
                if (_selectedMethod == 'Sin Contraseñas') ...[
                  Icon(
                    Icons.lock_open,
                    size: 120,
                    color: Colors.black,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Ingresar sin contraseñas',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ],
              ],
              if (autorizacion)
                Icon(
                  Icons.check_circle,
                  size: 60,
                  color: Colors.black,
                ),
              if (autorizacion)
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      autorizacion = false;
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => MenuPrincipal()));
                    });
                  },
                  child: const Text('Entrar'),
                )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_selectedMethod == 'Huella') {
            _autenticarHuella();
          } else if (_selectedMethod == 'PIN') {
            _autenticarPIN();
          } else if (_selectedMethod == 'Patrón') {
            _autenticarPatron();
          } else if (_selectedMethod == 'Sin Contraseñas') {
            _autenticarSinContrasenas();
          }
        },
        child: Icon(Icons.fingerprint),
      ),
    );
  }
}
