import 'package:flutter/material.dart';
import 'package:medidoc_doctor/logica_Autorizacion.dart';
import 'package:medidoc_doctor/pages/menu_principal.dart';

class BioPag extends StatefulWidget {
  const BioPag({Key? key}) : super(key: key);

  @override
  State<BioPag> createState() => _BioPagState();
}

class _BioPagState extends State<BioPag> {
  bool autorizacion = false;

  @override
  void initState() {
    super.initState();
    _autenticar(); 
  }

  Future<void> _autenticar() async {
    final autenticacion = await LAutorizacion.autenticar();
    setState(() {
      autorizacion = autenticacion;
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
                Icon(
                  Icons.fingerprint,
                  size: 120, 
                  color: Colors.black, 
                ),
                SizedBox(height: 10), 
                Text(
                  'Ingresar con huella o pin',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
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
        onPressed: _autenticar, 
        child: Icon(Icons.fingerprint),
      ),
    );
  }
}
