import 'package:agenda_contatos/autenticacao_service.dart';
import 'package:agenda_contatos/database_helper.dart';
import 'package:agenda_contatos/lista_contatos_screen.dart';
import 'package:agenda_contatos/login_screen.dart';
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
        await DatabaseHelper.createLoginTable(db);
      },
      version: 1,
    );

    final hasToken = await AuthService.verificarToken();

    runApp(MaterialApp(
      home: hasToken ? ListaContatosScreen() : LoginScreen(),
    ));
  } catch (e) {
    print('Erro na inicialização do banco: $e');
  }
}