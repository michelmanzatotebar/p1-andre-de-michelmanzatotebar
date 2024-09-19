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
  List<Contato> _contatos = [];

  @override
  void initState() {
    super.initState();
    _carregarContatos();
  }

  void _carregarContatos() {
    setState(() {
      _contatos = _contatoService.getContatos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agenda de Contatos'),
      ),
      body: _contatos.isEmpty
          ? Center(child: Text('Nenhum contato encontrado'))
          : ListView.builder(
        itemCount: _contatos.length,
        itemBuilder: (context, index) {
          Contato contato = _contatos[index];
          return ListTile(
            title: Text(contato.nome),
            subtitle: Text('${contato.telefone}\n${contato.email}'),
            onTap: () => _editarContato(contato),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarContato,
        child: Icon(Icons.add),
      ),
    );
  }

  void _adicionarContato() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AdicionarContatoScreen()),
    );
    if (result == true) {
      _carregarContatos();
    }
  }

  void _editarContato(Contato contato) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditarContatoScreen(contato: contato),
      ),
    );
    if (result == true) {
      _carregarContatos();
    }
  }
}