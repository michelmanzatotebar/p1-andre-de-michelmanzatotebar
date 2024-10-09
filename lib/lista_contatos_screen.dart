import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'contato_model.dart';
import 'contato_service.dart';
import 'adicionar_contato_screen.dart';
import 'editar_contato_screen.dart';

class ListaContatosScreen extends StatefulWidget {
  final Future<Database> database;

  const ListaContatosScreen({Key? key, required this.database}) : super(key: key);

  @override
  _ListaContatosScreenState createState() => _ListaContatosScreenState();
}

class _ListaContatosScreenState extends State<ListaContatosScreen> {
  late ContatoService _contatoService;

  @override
  void initState() {
    super.initState();
    _contatoService = ContatoService(widget.database);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda de Contatos'),
      ),
      body: FutureBuilder<List<Contato>>(
        future: _contatoService.listarContatos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum contato encontrado'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final contato = snapshot.data![index];
                return ListTile(
                  title: Text(contato.nome),
                  subtitle: Text('${contato.telefone}\n${contato.email}'),
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditarContatoScreen(
                          database: widget.database,
                          contato: contato,
                        ),
                      ),
                    );
                    setState(() {});
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AdicionarContatoScreen(database: widget.database),
            ),
          );
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
