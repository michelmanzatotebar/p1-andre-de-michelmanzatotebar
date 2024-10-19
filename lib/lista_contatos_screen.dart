import 'package:agenda_contatos/main.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'contato_model.dart';
import 'contato_service.dart';
import 'adicionar_contato_screen.dart';
import 'editar_contato_screen.dart';

class ListaContatosScreen extends StatefulWidget {
  @override
  _ListaContatosScreenState createState() => _ListaContatosScreenState();
}

class _ListaContatosScreenState extends State<ListaContatosScreen> {
  Future<List<Map<String, dynamic>>> _getContatos() async {
    try {
      return await globalDb.query('contatos');
    } catch (e) {
      print('Erro ao buscar contatos: $e');
      return [];
    }
  }

  void _atualizarLista() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agenda de Contatos'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _getContatos(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final contatos = snapshot.data ?? [];

          if (contatos.isEmpty) {
            return Center(child: Text('Nenhum contato cadastrado'));
          }

          return ListView.builder(
            itemCount: contatos.length,
            itemBuilder: (context, index) {
              final contato = contatos[index];
              return ListTile(
                title: Text(contato['nome'] ?? ''),
                subtitle: Text('${contato['telefone']}\n${contato['email']}'),
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditarContatoScreen(
                        contato: Contato(
                          id: contato['id'],
                          nome: contato['nome'],
                          telefone: contato['telefone'],
                          email: contato['email'],
                        ),
                      ),
                    ),
                  );
                  _atualizarLista();
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AdicionarContatoScreen(),
            ),
          );
          _atualizarLista();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
