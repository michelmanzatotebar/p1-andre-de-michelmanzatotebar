import 'dart:async';
import 'contato_model.dart';

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
  Future<void> atualizarContato(Contato contato) async {
    await Future.delayed(Duration(milliseconds: 500));
    int index = _contatos.indexWhere((c) => c.id == contato.id);
    if (index != -1) {
      _contatos[index] = contato;
    }
  }

  Future<void> excluirContato(String? id) async {
    await Future.delayed(Duration(milliseconds: 500));
    _contatos.removeWhere((contato) => contato.id == id);
  }
}