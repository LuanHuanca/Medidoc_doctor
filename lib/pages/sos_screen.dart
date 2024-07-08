import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'navBar.dart'; // Asegúrate de tener la importación correcta de tu NavBar
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class SOSSplashScreen extends StatefulWidget {
  const SOSSplashScreen({super.key});

  @override
  State<SOSSplashScreen> createState() => _SOSSplashScreenState();
}

class _SOSSplashScreenState extends State<SOSSplashScreen> {
  Future<Position> _determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            "Permisos de localización denegados permanentemente");
      } else if (permission == LocationPermission.denied) {
        return Future.error("Permisos de localización denegados");
      }
    }
    return await Geolocator.getCurrentPosition();
  }

Future<void> openInGoogleMaps() async {
    try {
      Position position = await _determinePosition();
      double latitude = position.latitude;
      double longitude = position.longitude;
      String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
      
      bool canLaunchUrl = await canLaunch(googleMapsUrl);
      if (canLaunchUrl) {
        await launch(googleMapsUrl);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open the map. Please ensure you have a web browser installed.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void _sendSOS(BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('SOS').add({
        'sos_signal': 1,
        'timestamp': FieldValue.serverTimestamp(),
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('SOS enviado con éxito'),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error al enviar SOS: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: const NavbarOptions(),
      body: Container(
        color: Colors.red,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'SOS',
                style: TextStyle(
                  fontSize: 72,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => openInGoogleMaps(),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.red,
                  backgroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                child: const Text('Enviar SOS'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
