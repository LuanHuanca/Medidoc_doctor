import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:medidoc_doctor/pages/Inicio.dart';
import 'package:medidoc_doctor/pages/biometrico.dart';
import 'package:medidoc_doctor/pages/perfil.dart';
import 'firebase_options.dart'; // Asegúrate de que este archivo exista y esté configurado correctamente

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
