import 'contato_model.dart';

class ContatoService {
  static final ContatoService _instance = ContatoService._internal();
  factory ContatoService() => _instance;
  ContatoService._internal();

  List<Contato> _contatos = [];
  int _nextId = 1;

  List<Contato> getContatos() {
    return List.from(_contatos);
  }

  void adicionarContato(Contato contato) {
    contato.id = _nextId.toString();
    _nextId++;
    _contatos.add(contato);
  }

  void atualizarContato(Contato contato) {
    int index = _contatos.indexWhere((c) => c.id == contato.id);
    if (index != 1) {
      _contatos[index] = contato;
    }
  }

  void excluirContato(String? id) {
    _contatos.removeWhere((contato) => contato.id == id);
  }
}