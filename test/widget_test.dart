import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agenda_contatos/main.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {

  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  testWidgets('Verifica se o título da AppBar está correto', (WidgetTester tester) async {

    final database = await openDatabase(inMemoryDatabasePath, version: 1,
        onCreate: (db, version) async {
          await db.execute(
              'CREATE TABLE contatos(id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, telefone TEXT, email TEXT)');
        });


    await tester.pumpWidget(AgendaApp(database: Future.value(database)));


    expect(find.text('Agenda de Contatos'), findsOneWidget);
  });

  testWidgets('Verifica se o botão de adicionar contato está presente', (WidgetTester tester) async {

    final database = await openDatabase(inMemoryDatabasePath, version: 1,
        onCreate: (db, version) async {
          await db.execute(
              'CREATE TABLE contatos(id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, telefone TEXT, email TEXT)');
        });


    await tester.pumpWidget(AgendaApp(database: Future.value(database)));

    expect(find.byType(FloatingActionButton), findsOneWidget);
  });
}