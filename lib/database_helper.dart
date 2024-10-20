import 'package:sqflite/sqlite_api.dart';

class DatabaseHelper {
  static Future<void> createLoginTable(Database db) async {
    await db.execute('''
      CREATE TABLE usuarios(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        usuario TEXT UNIQUE,
        senha TEXT
      )
    ''');
  }
}
