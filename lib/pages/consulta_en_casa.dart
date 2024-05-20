import 'package:flutter/material.dart';
import 'chat_screen.dart';

class ConsultaEnCasa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consulta en casa'),
        backgroundColor: Color(0xFF02457A),
      ),
      body: Container(
        color: Color(0xFF02457A),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 24,
              ),
              title: Text(
                'Baffa Stefano',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatScreen()),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Acción para el botón flotante
        },
        backgroundColor: Colors.grey,
        child: Icon(Icons.add),
      ),
    );
  }
}
