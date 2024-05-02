import 'package:flutter/material.dart';
import 'package:medidoc_doctor/pages/navBar.dart';

class Perfil extends StatelessWidget {
  const Perfil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Perfil',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      drawer: const NavbarOptions(),
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepPurpleAccent,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.account_circle_sharp,
                    size: 80,
                    color: Colors.white,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'medidoc_doctor@ucb.edu.bo',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OptionButton(
                  icon: Icons.fingerprint,
                  label: 'Uso de huella',
                  onPressed: () {
                    print("Uso de huella");
                  },
                ),
                OptionButton(
                  icon: Icons.g_mobiledata,
                  label: 'Correo electrónico',
                  onPressed: () {
                    print("Correo electrónico");
                  },
                ),
                OptionButton(
                  icon: Icons.privacy_tip_outlined,
                  label: 'Política de privacidad',
                  onPressed: () {
                    print("Política de privacidad");
                  },
                ),
                OptionButton(
                  icon: Icons.settings,
                  label: 'Configuración',
                  onPressed: () {
                    print("Configuración");
                  },
                ),
                OptionButton(
                  icon: Icons.card_membership,
                  label: 'Identificador del dispositivo',
                  onPressed: () {
                    print("Identificador del dispositivo");
                  },
                ),
                OptionButton(
                  icon: Icons.circle_notifications_rounded,
                  label: 'Notificaciones',
                  onPressed: () {
                    print("Notificaciones");
                  },
                ),
                OptionButton(
                  icon: Icons.exit_to_app,
                  label: 'Cerrar sesión',
                  onPressed: () {
                    print("Cerrar sesión");
                  },
                ),
                OptionButton(
                  icon: Icons.cancel_sharp,
                  label: 'Cancelar',
                  onPressed: () {
                    print("Cancelar");
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OptionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const OptionButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: 40,
      ),
      label: Text(label, style: const TextStyle(fontSize: 22)),
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
      ),
    );
  }
}
