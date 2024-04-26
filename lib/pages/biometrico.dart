import 'package:flutter/material.dart';
import 'package:medidoc_doctor/logica_Autorizacion.dart';
import 'package:medidoc_doctor/pages/menu_principal.dart';

class BioPag extends StatefulWidget {
  const BioPag({super.key});

  @override
  State<BioPag> createState() => _BioPagState();
}

class _BioPagState extends State<BioPag> {
  bool autorizacion= false;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Registro Biometrico'),
        centerTitle: true,
      ),

      floatingActionButton: autorizacion==true ? null : 
      FloatingActionButton(
        onPressed: ()async{
          final autenticacion = await LAutorizacion.autenticar();
          setState(() {
            autorizacion= autenticacion;
          });
        }
        ,child: Icon(Icons.fingerprint),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(!autorizacion)
            const Icon(
              Icons.warning,
              size: 60,
            ),
            if(autorizacion)
            Icon(Icons.check_circle, size:60),
            if(autorizacion)
            ElevatedButton(
              onPressed: (){
                setState(() {
                  autorizacion=false;
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => MenuPrincipal()));
                });
              }, child: const Text('Entrar')) 
          ],
        ),)

    );
  }
}