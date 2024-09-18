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
      body: FutureBuilder<List<Contato>>(
        future: _contatoService.getContatos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar contatos'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum contato encontrado'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Contato contato = snapshot.data![index];
              return ListTile(
                title: Text(contato.nome),
                subtitle: Text('${contato.telefone}\n${contato.email}'),
                onTap: () => _editarContato(contato),
              );
            },
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
    if (result != null) {
      setState(() {});
    }
  }

  void _editarContato(Contato contato) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditarContatoScreen(contato: contato),
      ),
    );
    if (result != null) {
      setState(() {});
    }
  }
}