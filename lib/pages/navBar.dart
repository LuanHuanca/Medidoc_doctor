import 'package:flutter/material.dart';

class NavbarOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
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
                    'medidoc@ucb.edu.bo',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.deepPurpleAccent,
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OptionButton(
                icon: Icons.fingerprint,
                label: 'Uso de huella',
                onPressed: () {
                  print("Uso de huella");
                  Navigator.pop(context);
                },
              ),
              OptionButton(
                icon: Icons.g_mobiledata,
                label: 'Correo electrónico',
                onPressed: () {
                  print("Correo electrónico");
                  Navigator.pop(context);
                },
              ),
              OptionButton(
                icon: Icons.privacy_tip_outlined,
                label: 'Política de privacidad',
                onPressed: () {
                  print("Política de privacidad");
                  Navigator.pop(context);
                },
              ),
              OptionButton(
                icon: Icons.settings,
                label: 'Configuración',
                onPressed: () {
                  print("Configuración");
                  Navigator.pop(context);
                },
              ),
              OptionButton(
                icon: Icons.card_membership,
                label: 'Identificador del dispositivo',
                onPressed: () {
                  print("Identificador del dispositivo");
                  Navigator.pop(context);
                },
              ),
              OptionButton(
                icon: Icons.medical_services_rounded,
                label: 'Medicaciones',
                onPressed: () {
                  print("Medicaciones");
                  Navigator.pop(context);
                },
              ),
              OptionButton(
                icon: Icons.exit_to_app,
                label: 'Cerrar sesión',
                onPressed: () {
                  print("Cerrar sesión");
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
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(
          icon,
          size: 40,
      ),
      label: Text(
        label,
        style: const TextStyle(fontSize: 22)
      ),
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent),

      ),
    );
  }
}
