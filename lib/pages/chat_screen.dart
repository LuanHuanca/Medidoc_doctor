import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatScreen extends StatefulWidget {
  final Map<String, dynamic> user;

  const ChatScreen({super.key, required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _userMessageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];

  void _sendMessage() {
    final messageText = _userMessageController.text.trim();
    if (messageText.isNotEmpty) {
      setState(() {
        _messages.add({"text": messageText, "isUser": true});
      });
      _userMessageController.clear();
      _simulateResponse();
    }
  }

  void _simulateResponse() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _messages.add({"text": "Respuesta automática", "isUser": false});
      });
    });
  }

  Future<void> openInGoogleMaps() async {
    try {
      // Obtiene la latitud y longitud del primer paciente
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Paciente').limit(1).get();
      if (snapshot.docs.isNotEmpty) {
        var paciente = snapshot.docs.first.data() as Map<String, dynamic>;
        double latitude = paciente['latitude'];
        double longitude = paciente['longitude'];

        String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
        Uri uri = Uri.parse(googleMapsUrl);

        try {
          await launchUrl(uri, mode: LaunchMode.externalNonBrowserApplication);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'No se pudo abrir el mapa. Asegúrate de tener un navegador web instalado.')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No se encontró ningún paciente.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chat con ${widget.user['nombre']}',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF02457A),
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/icons/mapa.png', // Reemplaza con la ruta de tu imagen
              width: 40,
              height: 40,
            ),
            onPressed: () => openInGoogleMaps(),
            color: Colors.white,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Container(
                  alignment: message['isUser']
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: message['isUser'] ? Colors.blue : Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      message['text'],
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _userMessageController,
                    decoration: InputDecoration(
                      hintText: 'Escribe un mensaje...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
