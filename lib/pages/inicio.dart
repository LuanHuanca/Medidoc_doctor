import 'dart:math';
import 'package:flutter/material.dart';
import 'package:medidoc_doctor/pages/menu_principal.dart';

class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> with SingleTickerProviderStateMixin {
  late AnimationController controladorAnimacion;

  @override
  void initState() {
    super.initState();
    controladorAnimacion = AnimationController(
      duration: Duration(seconds: 60),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    controladorAnimacion.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final alturaPantalla = MediaQuery.of(context).size.height;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => MenuPrincipal())); // Modifica esto por tu destino
        },
        child: Container(
          color: Color(0xFF003459),
          child: Stack(
            children: [
              CapaOla(
                animacion: controladorAnimacion,
                proporcionAltura: 0.1,
                velocidad: 1.0,
                desfase: pi,
                color: Color(0xFF00171F).withOpacity(0.7),
                inicioY: alturaPantalla * 0.3,
              ),
              CapaOla(
                animacion: controladorAnimacion,
                proporcionAltura: 0.15,
                velocidad: 1.1,
                desfase: pi / 2,
                color: Color(0xFF005F73).withOpacity(0.7),
                inicioY: alturaPantalla * 0.1,
              ),
              CapaOla(
                animacion: controladorAnimacion,
                proporcionAltura: 0.1,
                velocidad: 1.0,
                desfase: pi / 3,
                color: Color(0xFF0A9396).withOpacity(0.7),
                inicioY: alturaPantalla * 0.6,
              ),
              CapaOla(
                animacion: controladorAnimacion,
                proporcionAltura: 0.1,
                velocidad: 1.3,
                desfase: pi / 3,
                color: Color(0xFF94D2BD).withOpacity(0.7),
                inicioY: alturaPantalla * 0.8,
              ),
              Center(
                child: Text(
                  'Doctor Toc',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Roboto', // Fuente más seria
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CapaOla extends StatelessWidget {
  final AnimationController animacion;
  final double proporcionAltura;
  final double velocidad;
  final double desfase;
  final Color color;
  final double inicioY;

  const CapaOla({
    Key? key,
    required this.animacion,
    required this.proporcionAltura,
    required this.velocidad,
    required this.desfase,
    required this.color,
    required this.inicioY,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animacion,
      builder: (context, child) {
        return CustomPaint(
          painter: PintorOla(
            valorAnimacion: animacion.value,
            proporcionAltura: proporcionAltura,
            velocidad: velocidad,
            desfase: desfase,
            color: color,
            inicioY: inicioY,
          ),
          size: Size(double.infinity, double.infinity),
        );
      },
    );
  }
}

class PintorOla extends CustomPainter {
  final double valorAnimacion;
  final double proporcionAltura;
  final double velocidad;
  final double desfase;
  final Color color;
  final double inicioY;

  PintorOla({
    required this.valorAnimacion,
    required this.proporcionAltura,
    required this.velocidad,
    required this.desfase,
    required this.color,
    required this.inicioY,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();

    final alturaOla = size.height * proporcionAltura;
    final frecuenciaOla = 2 * pi / size.width;
    final desplazamientoTotalOla = 2 * pi * valorAnimacion * velocidad + desfase;

    path.moveTo(0, inicioY);
    for (double x = 0; x <= size.width; x++) {
      final y = inicioY + alturaOla * sin(frecuenciaOla * x + desplazamientoTotalOla);
      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
