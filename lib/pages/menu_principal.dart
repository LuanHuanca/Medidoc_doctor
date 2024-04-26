import 'package:flutter/material.dart';
import 'package:medidoc_doctor/pages/asistente_page.dart';
import 'package:medidoc_doctor/pages/formulario.dart';
import 'package:medidoc_doctor/pages/navBar.dart';

class MenuPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medidoc'),
      ),
      drawer: NavbarOptions(),
      backgroundColor: Colors.white,
      body: Center(
        child: Navigator(
          onGenerateRoute: ((settings) {
            return MaterialPageRoute(
              builder: (context) => _buildContent(context, settings),
            );
          }),
        ),
      ),
    );
  }
}

Widget _buildContent(BuildContext context, RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return Column(
        children: [
          Expanded(
            child: Center(
                child: MyCustomButtonColumn()
            ),
          ),
        ],
      );
    case '/asistente':
      return AsistentePage();
    case '/formulario':
      return Formulario();
    default:
      return Container();
  }
}

class MyCustomButtonColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MyCustomButton(
          text: "Asistente Personal",
          onPressed: () {
            Navigator.pushNamed(
                context, '/asistente');
          },
        ),
        SizedBox(height: 22),
        MyCustomButton(
          text: "Formulario",
          onPressed: () {
            Navigator.pushNamed(
                context, '/formulario');
          },
        ),
        SizedBox(height: 22),
        MyCustomButton(
          text: "Opcion Tres",
          onPressed: () {},
        ),
        SizedBox(height: 22),
        MyCustomButton(
          text: "Opcion Cuatro",
          onPressed: () {},
        ),
      ],
    );
  }
}

class MyCustomButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final double width;
  final double height;

  MyCustomButton({
    required this.text,
    required this.onPressed,
    this.width = 250.0,
    this.height = 80.0,
  });

  @override
  _MyCustomButtonState createState() => _MyCustomButtonState();
}

class _MyCustomButtonState extends State<MyCustomButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          isPressed = false;
        });
        // Aquí llamarías a la función que deseas que se ejecute al presionar.
        widget.onPressed?.call();
      },
      onTapCancel: () {
        setState(() {
          isPressed = false;
        });
      },
      child: SizedBox(
        width: widget.width, // Usa el ancho pasado al widget
        height: widget.height,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200), // Duración de la animación
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
              colors: isPressed
                  ? [
                      Colors.purple,
                      Colors.purpleAccent
                    ] // Colores cuando está presionado
                  : [
                      Color(0xFF6F35A5),
                      Color(0xFFB388FF)
                    ], // Colores originales
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius:
                    isPressed ? 0 : 2, // Eliminar sombra cuando está presionado
                blurRadius: isPressed ? 0 : 6,
                offset: isPressed ? Offset(0, 0) : Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            widget.text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
