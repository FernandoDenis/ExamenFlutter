import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agenda de Contactos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AgendaScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Agenda {
  String nombre;
  String control;

  Agenda(this.nombre, this.control);
}

class AgendaScreen extends StatefulWidget {
  @override
  _AgendaScreenState createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  final _nombreController = TextEditingController();
  final _controlController = TextEditingController();
  List<Agenda> _contactos = [];
  String _contactCount = '0';

  void _agregarContacto() {
    String nombre = _nombreController.text;
    String control = _controlController.text;

    if (nombre.isNotEmpty && control.isNotEmpty) {
      setState(() {
        _contactos.add(Agenda(nombre, control));
        _contactCount = _contactos.length.toString();
        _nombreController.clear();
        _controlController.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, completa todos los campos.')),
      );
    }
  }

  void _verAgenda() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListadoContactosScreen(contactos: _contactos),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App segunda parcial'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Agenda',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(labelText: 'Nombre completo'),
            ),
            TextField(
              controller: _controlController,
              decoration: InputDecoration(labelText: 'No control'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _agregarContacto,
                child: Text('Agregar'),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                '$_contactCount',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Divider(thickness: 2, color: Colors.green),
            Center(
              child: ElevatedButton(
                onPressed: _verAgenda,
                child: Text('Ver agenda'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListadoContactosScreen extends StatelessWidget {
  final List<Agenda> contactos;

  ListadoContactosScreen({required this.contactos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listado de contactos'),
      ),
      body: ListView.builder(
        itemCount: contactos.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              child: Text(contactos[index].nombre[0]),
            ),
            title: Text(contactos[index].nombre),
            subtitle: Text(contactos[index].control),
          );
        },
      ),
    );
  }
}
