import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'navBar.dart'; // Asegúrate de tener la importación correcta de tu NavBar

class SOSSplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: NavbarOptions(),
      body: Container(
        color: Colors.red,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'SOS',
                style: TextStyle(
                  fontSize: 72,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _sendSOS(context),
                child: Text('Enviar SOS'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.red, backgroundColor: Colors.white, // Texto rojo
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendSOS(BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('SOS').add({
        'sos_signal': 1,
        'timestamp': FieldValue.serverTimestamp(), // Añade un timestamp para referencia
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('SOS enviado con éxito'),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error al enviar SOS: $e'),
      ));
    }
  }
}
