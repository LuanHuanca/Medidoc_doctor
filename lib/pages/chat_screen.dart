import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        backgroundColor: Color(0xFF02457A),
      ),
      body: Center(
        child: Text('Esta es la pantalla del chat'),
      ),
    );
  }
}
