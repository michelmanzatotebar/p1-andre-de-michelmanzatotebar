import 'package:sqflite/sqflite.dart';
import 'contato_model.dart';

class ContatoService {
  final Future<Database> database;

  ContatoService(this.database);

  Future<void> inserirContato(Contato contato) async {
    final db = await database;
    await db.insert(
      'contatos',
      contato.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Contato>> listarContatos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('contatos');
    return List.generate(maps.length, (i) {
      return Contato.fromMap(maps[i]);
    });
  }

  Future<void> atualizarContato(Contato contato) async {
    final db = await database;
    await db.update(
      'contatos',
      contato.toMap(),
      where: 'id = ?',
      whereArgs: [contato.id],
    );
  }

  Future<void> deletarContato(int id) async {
    final db = await database;
    await db.delete(
      'contatos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}