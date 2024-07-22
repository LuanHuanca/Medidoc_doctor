import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'navBar.dart';

class SOSSplashScreen extends StatefulWidget {
  const SOSSplashScreen({Key? key}) : super(key: key);

  @override
  State<SOSSplashScreen> createState() => _SOSSplashScreenState();
}

class _SOSSplashScreenState extends State<SOSSplashScreen> {
  late Stream<QuerySnapshot> _sosStream;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchSOSData(); // Cargar los datos al inicio
  }

  void _fetchSOSData() {
    setState(() {
      _isLoading = true; // Mostrar el CircularProgressIndicator
    });

    FirebaseFirestore.instance
        .collection('SOS')
        .orderBy('timestamp', descending: true)
        .get()
        .then((querySnapshot) {
      setState(() {
        _sosStream =
            Stream.value(querySnapshot); // Convertir el resultado en un Stream
        _isLoading = false; // Ocultar el CircularProgressIndicator
      });
    }).catchError((error) {
      setState(() {
        _isLoading =
            false; // Manejar errores y ocultar el CircularProgressIndicator
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al cargar los datos: $error'),
        ),
      );
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'Location services are disabled.';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        throw 'Location permissions are permanently denied, we cannot request permissions.';
      }

      if (permission == LocationPermission.denied) {
        throw 'Location permissions are denied';
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> openInGoogleMaps(double latitude, double longitude) async {
    try {
      String googleMapsUrl =
          'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

      Uri uri = Uri.parse(googleMapsUrl);

      try {
        await launch(uri.toString(), forceSafariVC: false, forceWebView: false);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Could not open the map. Please ensure you have a web browser installed.'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    }
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Center(child: Text('Éxito')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 50),
              SizedBox(height: 20),
              Text('SOS enviado con éxito'),
            ],
          ),
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cerrar'),
              ),
            ),
          ],
        );
      },
    );
  }

  void _refreshList() {
    setState(() {
      _isLoading = true; // Mostrar el CircularProgressIndicator
    });

    _fetchSOSData(); // Llamar a la función para actualizar los datos
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'SOS Pendientes',
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.refresh),
                  color: Colors.white,
                  onPressed: () => _refreshList(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Stack(
                children: [
                  _isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : StreamBuilder<QuerySnapshot>(
                          stream: _sosStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            }

                            if (!snapshot.hasData ||
                                snapshot.data!.docs.isEmpty) {
                              return Center(
                                  child: Text('No hay solicitudes pendientes'));
                            }

                            return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                var sos = snapshot.data!.docs[index];
                                double latitude = sos['latitude'];
                                double longitude = sos['longitude'];

                                return Card(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: ListTile(
                                    title: Text('Solicitud ${index + 1}'),
                                    subtitle: Text(
                                        'Ubicación: $latitude, $longitude'),
                                    trailing: ElevatedButton(
                                      onPressed: () =>
                                          openInGoogleMaps(latitude, longitude),
                                      child: Text('Acceder a la Ubicación'),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
