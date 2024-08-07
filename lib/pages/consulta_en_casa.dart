import 'package:flutter/material.dart';
import 'chat_screen.dart';

class ConsultaEnCasa extends StatefulWidget {
  const ConsultaEnCasa({super.key});

  @override
  State<ConsultaEnCasa> createState() => _ConsultaEnCasaState();
}

class _ConsultaEnCasaState extends State<ConsultaEnCasa> {
  final List<Map<String, dynamic>> _allUsers = [
    {"id": "yLXmGYygxi99CSB2XQHR", "nombre": "Pedro", "genero": "masculino"},
    {"id": "2", "nombre": "Juan", "genero": "masculino"},
    {"id": "3", "nombre": "Jose", "genero": "masculino"},
    {"id": "4", "nombre": "Maria", "genero": "femenino"},
    {"id": "5", "nombre": "Anahi", "genero": "femenino"},
    {"id": "6", "nombre": "Ana", "genero": "femenino"},
    {"id": "7", "nombre": "Joaquin", "genero": "masculino"},
    {"id": "8", "nombre": "Alvaro", "genero": "masculino"},
    {"id": "9", "nombre": "Max", "genero": "masculino"},
    {"id": "10", "nombre": "Camila", "genero": "femenino"},
    {"id": "11", "nombre": "Jaime", "genero": "masculino"},
  ];

  List<Map<String, dynamic>> _foundUsers = [];

  @override
  void initState() {
    _foundUsers = _allUsers;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) => user["nombre"]
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundUsers = results;
    });
  }

  void _showAddUserDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String name = '';
        String gender = 'masculino';
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Añadir Nuevo Paciente'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: const InputDecoration(labelText: 'Nombre'),
                    onChanged: (value) {
                      name = value;
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text('Género: '),
                      Expanded(
                        child: DropdownButton<String>(
                          value: gender,
                          isExpanded: true,
                          onChanged: (String? newValue) {
                            setState(() {
                              gender = newValue!;
                            });
                          },
                          items: <String>['masculino', 'femenino']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    if (name.isNotEmpty) {
                      setState(() {
                        String newId = (_allUsers.length + 1).toString();
                        _allUsers.add({
                          "id": newId,
                          "nombre": name,
                          "genero": gender
                        });
                        _foundUsers = _allUsers;
                      });
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Añadir'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Consulta en Casa",
            style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF02457A),
      ),
      body: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                  labelText: 'Buscar', suffixIcon: Icon(Icons.search)),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _foundUsers.length,
                itemBuilder: (context, index) => Card(
                  key: ValueKey(_foundUsers[index]['id']),
                  color: const Color(0xFF97CADB),
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 24,
                    ),
                    title: Text(
                      _foundUsers[index]['nombre'],
                      style: const TextStyle(color: Colors.black),
                    ),
                    subtitle: Text(
                      _foundUsers[index]["genero"].toString(),
                      style: const TextStyle(color: Colors.black),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChatScreen(user: _foundUsers[index])),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddUserDialog,
        backgroundColor: const Color(0xFF018ABE),
        child: const Icon(Icons.add),
      ),
    );
  }
}
