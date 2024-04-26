import 'package:flutter/material.dart';
import 'package:medidoc_doctor/pages/asistente_page.dart';
import 'package:medidoc_doctor/pages/Inicio.dart';
import 'package:medidoc_doctor/pages/biometrico.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medidoc',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      routes: {
        '/':(context)=> Inicio(),
        '/asistente':(context) => AsistentePage(),
        '/registro':(context) => BioPag(),
      },
    );
  }
}
