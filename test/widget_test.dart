import 'package:flutter_test/flutter_test.dart';
import 'package:agenda_contatos/main.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  testWidgets('App pode ser construído', (WidgetTester tester) async {
    // Inicializa o sqflite para testes
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    // Cria um banco de dados em memória para testes
    final database = await openDatabase(inMemoryDatabasePath, version: 1,
        onCreate: (db, version) async {
          await db.execute(
              'CREATE TABLE contatos(id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, telefone TEXT, email TEXT)');
        });

    // Constrói nosso app e dispara um frame.
    await tester.pumpWidget(AgendaApp(database: Future.value(database)));

    // Se chegamos até aqui sem erros, o teste passa.
    expect(true, isTrue);
  });
}