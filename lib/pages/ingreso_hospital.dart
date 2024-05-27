import 'package:flutter/material.dart';

class IngresoHospital extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ingreso Hospitalario'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField('Fecha de hoy'),
            _buildTextField('Nombre del Paciente'),
            _buildTextField('Fecha de Nacimiento'),
            _buildTextField('Edad'),
            _buildGenderSelection(),
            _buildTextField('Domicilio'),
            _buildTextField('Ciudad'),
            _buildTextField('Estado'),
            _buildTextField('Código Postal'),
            _buildTextField('Celular'),
            _buildTextField('Teléfono de casa'),
            _buildTextField('Seguro Social'),
            _buildTextField('Licencia de Manejar'),
            _buildTextField('Correo Electrónico'),
            _buildTextField('Empleador'),
            _buildTextField('Ocupación'),
            _buildTextField('Teléfono del Trabajo'),
            _buildTextField('Ext.'),
            _buildTextField('Dirección del Trabajo'),
            _buildTextField('Ciudad del Trabajo'),
            _buildTextField('Estado del Trabajo'),
            _buildTextField('Código Postal del Trabajo'),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildGenderSelection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text('Género:'),
          SizedBox(width: 20),
          Row(
            children: [
              Radio(value: 'Masculino', groupValue: 'gender', onChanged: (value) {}),
              Text('Masculino'),
            ],
          ),
          Row(
            children: [
              Radio(value: 'Femenino', groupValue: 'gender', onChanged: (value) {}),
              Text('Femenino'),
            ],
          ),
        ],
      ),
    );
  }
}
