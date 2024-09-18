import 'dart:async';
import 'contato.dart';

class ContatoService{
  List<Contato> _contatos = [];
  int _nextId = 1;
  Future<List<Contato>> getContatos() async{
    await Future.delayed(Duration(milliseconds: 500));
    return _contatos;
  }
  Future<void> adicionarContato(Contato contato) async{
    await Future.delayed(Duration(milliseconds: 500));
    contato.id= _nextId.toString();
    _nextId++;
    _contatos.add(contato);
  }
}