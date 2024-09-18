import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

void main() {
  runApp(AgendaApp());
}

class AgendaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Agenda de Contatos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    home: ListaContatosScreen(),
    );


    throw UnimplementedError();
  }
  
}

class Contato {
  String nome,telefone,email;
  Contato({required this.nome, required this.telefone, required this.email});
}

class ListaContatosScreen extends StatefulWidget{
  @override
  _ListaContatosScreenState createState() => _ListaContatosScreenState();
}
class _ListaContatosScreenState extends State<ListaContatosScreen> {
  List<Contato> contatos = [];
  @override
  Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(title: Text('Agenda de Contatos'),
    ),
    body: ListView.builder(
      itemCount: contatos.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(contatos[index].nome),
          subtitle: Text('${contatos[index].telefone}\n${contatos[index].email}'),
          onTap: () => _editarContato(index),
        );
      },
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: _adicionarContato,
      child: Icon(Icons.add),
    ),
  );
  }
}

class _adicionarContato {
}

class _editarContato {
}
