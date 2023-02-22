import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;
  List<dynamic> examenes = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<List<dynamic>> getExamenesDisponibles() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.77:8000/api/auth/examenes'));

    if (response.statusCode == 200) {
      // si la solicitud fue exitosa, parsea la respuesta y devuelve los datos como una lista dinámica
      return json.decode(response.body);
    } else {
      // si la solicitud no fue exitosa, lanza una excepción con el mensaje de error
      throw Exception(
          'Error al obtener los exámenes disponibles: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    getExamenesDisponibles().then((examenes) {
      setState(() {
        this.examenes = examenes;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: examenes.length,
          itemBuilder: (context, index) {
            final examen = examenes[index];
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13.0)),
              elevation: 10,
              child: ListTile(
                leading: Icon(Icons.event),
                title:
                    Text(examen['examen_des'], style: TextStyle(fontSize: 20)),
                subtitle: Text('Fecha De Examen: ${examen['Fecha_Examen']}'),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.event_available),
            label: 'Citas Disponibles',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
