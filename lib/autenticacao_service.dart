import 'package:agenda_contatos/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String TOKEN_KEY = 'user_token';

  static Future<bool> login(String usuario, String senha) async {
    try {
      final result = await globalDb.query(
        'usuarios',
        where: 'usuario = ? AND senha = ?',
        whereArgs: [usuario, senha],
      );

      if (result.isNotEmpty) {
        await SharedPreferences.getInstance()
            .then((prefs) => prefs.setString(TOKEN_KEY, usuario));
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> cadastrar(String usuario, String senha) async {
    try {
      await globalDb.insert('usuarios', {
        'usuario': usuario,
        'senha': senha,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> verificarToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(TOKEN_KEY);
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(TOKEN_KEY);
  }
}