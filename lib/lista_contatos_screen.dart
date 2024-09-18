import 'package:flutter/material.dart';
import 'package:trabalhop1andredemichelmanzatotebar/main.dart';
import 'contato.dart';
import 'contato_service.dart';


class ListaContatosScreen extends StatefulWidget{
  @override
  _ListaContatosScreenState createState() => _ListaContatosScreenState();
}
class _ListaContatosScreenState extends State<ListaContatosScreen> {
  final ContatoService _contatoService = ContatoService();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Agenda de Contatos'),
      ),
     body: FutureBuilder<List<Contato>>(
       future: _contatoService.getContatos(),
       builder: (context, snapshot){
         if(snapshot.connectionState == ConnectionState.waiting){
           return Center(child: CircularProgressIndicator());
         }else if(snapshot.hasError){
           return Center(child: Text('Erro ao encontrar o contato'));
         }else if(!snapshot.hasData || snapshot.data!.isEmpty){
           return Center(child: Text('Nenhum contato encontrado'));
         }
         return ListView.builder(
           itemCount: snapshot.data!.length,
           itemBuilder: (context, index){
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
    );
  }
}

class _editarContato (Contato contato){
}

