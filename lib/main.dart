import 'package:flutter/material.dart';
import 'lista_contatos_screen.dart';

void main() {
  runApp(AgendaApp());
}

class AgendaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Agenda de Contatos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    home: ListaContatosScreen(),
    );
  }
}