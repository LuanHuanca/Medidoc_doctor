import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:medidoc_doctor/pages/Inicio.dart';
import 'package:medidoc_doctor/pages/biometrico.dart';
import 'package:medidoc_doctor/pages/perfil.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medidoc_doctor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => Inicio(),
        '/perfil': (context) => Perfil(),
        '/registro': (context) => BioPag(),
      },
    );
  }
}
