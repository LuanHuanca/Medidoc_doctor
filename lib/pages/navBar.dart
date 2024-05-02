import 'dart:io';
import 'package:flutter/material.dart';
import 'package:medidoc_doctor/pages/asistente_page.dart';
import 'package:medidoc_doctor/pages/formulario.dart';
import 'package:medidoc_doctor/pages/menu_principal.dart';
import 'package:medidoc_doctor/pages/perfil.dart';

class NavbarOptions extends StatelessWidget {
  const NavbarOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.purple,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 8),
              _buildDrawerOption(
                title: 'Inicio',
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MenuPrincipal()));
                },
              ),
              _buildDrawerOption(
                title: 'Perfil',
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Perfil()));
                },
              ),
                            _buildDrawerOption(
                title: 'Formulario',
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Formulario()));
                },
              ),
              _buildDrawerOption(
                title: 'Asistente',
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const AsistentePage()));
                },              ),
              _buildDrawerOption(
                title: 'Salir',
                onTap: () {
                  exit(0);
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerOption(
      {required String title, required VoidCallback onTap}) {
    return Container(
      margin: const EdgeInsets.all(4.0), // Margen alrededor de cada botón
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white), // Borde del botón color blanco
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(color: Colors.white), // Texto de color blanco
          textAlign: TextAlign.center, // Alineación del texto al centro
        ),
        onTap: onTap,
      ),
    );
  }
}
