import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'lista_contatos_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = openDatabase(
    join(await getDatabasesPath(), 'agenda_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE contatos(id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, telefone TEXT, email TEXT)',
      );
    },
    version: 1,
  );
  runApp(AgendaApp(database: database));
}

class AgendaApp extends StatelessWidget {
  final Future<Database> database;

  const AgendaApp({Key? key, required this.database}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agenda de Contatos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListaContatosScreen(database: database),
    );
  }
}