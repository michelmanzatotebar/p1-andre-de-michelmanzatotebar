import 'package:agenda_contatos/lista_contatos_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

late Database globalDb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    globalDb = await openDatabase(
      join(await getDatabasesPath(), 'agenda_database.db'),
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE contatos(id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, telefone TEXT, email TEXT)',
        );
      },
      onOpen: (db) async {
        // Verifica se a tabela existe
        var tables = await db.rawQuery(
            "SELECT name FROM sqlite_master WHERE type='table' AND name='contatos'");
        if (tables.isEmpty) {
          await db.execute(
            'CREATE TABLE contatos(id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, telefone TEXT, email TEXT)',
          );
        }
      },
      version: 1,
    );

    runApp(AgendaApp());
  } catch (e) {
    print('Erro na inicialização do banco: $e');
  }
}

class AgendaApp extends StatelessWidget {
  const AgendaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agenda de Contatos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListaContatosScreen(),
    );
  }
}