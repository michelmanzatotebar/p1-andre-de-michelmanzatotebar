import 'package:flutter/material.dart';
import 'contato_model.dart';
import 'editar_contato_screen.dart';
import 'adicionar_contato_screen.dart';
import 'contato_service.dart';

class ListaContatosScreen extends StatefulWidget {
  @override
  _ListaContatosScreenState createState() => _ListaContatosScreenState();
}

class _ListaContatosScreenState extends State<ListaContatosScreen> {
  final ContatoService _contatoService = ContatoService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agenda de Contatos'),
      ),
      body: _buildContatosList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarContato,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildContatosList() {
    List<Contato> contatos = _contatoService.getContatos();

    if (contatos.isEmpty) {
      return Center(child: Text('Nenhum contato encontrado'));
    }

    return ListView.builder(
      itemCount: contatos.length,
      itemBuilder: (context, index) {
        Contato contato = contatos[index];
        return ListTile(
          title: Text(contato.nome),
          subtitle: Text('${contato.telefone}\n${contato.email}'),
          onTap: () => _editarContato(contato),
        );
      },
    );
  }

  void _adicionarContato() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AdicionarContatoScreen()),
    ).then((value) {
      if (value == true) {
        setState(() {});
      }
    });
  }

  void _editarContato(Contato contato) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditarContatoScreen(contato: contato),
      ),
    ).then((value) {
      if (value == true) {
        setState(() {});
      }
    });
  }
}