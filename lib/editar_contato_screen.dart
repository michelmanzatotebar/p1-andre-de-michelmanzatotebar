import 'package:flutter/material.dart';
import 'contato_model.dart';
import 'contato_service.dart';
import 'package:email_validator/email_validator.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class EditarContatoScreen extends StatefulWidget {
  final Contato contato;

  EditarContatoScreen({required this.contato});

  @override
  _EditarContatoScreenState createState() => _EditarContatoScreenState();
}

class _EditarContatoScreenState extends State<EditarContatoScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomeController;
  late TextEditingController _telefoneController;
  late TextEditingController _emailController;
  final ContatoService _contatoService = ContatoService();

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.contato.nome);
    _telefoneController = TextEditingController(text: widget.contato.telefone);
    _emailController = TextEditingController(text: widget.contato.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Contato'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _telefoneController,
                decoration: InputDecoration(labelText: 'Telefone'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um telefone';
                  }
                  if (value.length < 14) {
                    return 'Telefone inválido, verifique se colocou () e - no número';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um e-mail';
                  }
                  if (!EmailValidator.validate(value)) {
                    return 'E-mail inválido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvarContato,
                child: Text('Salvar'),
              ),
              ElevatedButton(
                onPressed: _excluirContato,
                child: Text('Excluir'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
  String formatarTelefone(String telefone) {
    if (telefone.length != 11) return telefone;
    return '(${telefone.substring(0, 2)}) ${telefone.substring(2, 7)}-${telefone.substring(7)}';
  }

  void _salvarContato() {
    if (_formKey.currentState!.validate()) {
      Contato novoContato = Contato(
        nome: _nomeController.text,
        telefone: formatarTelefone(_telefoneController.text),
        email: _emailController.text,
      );
      _contatoService.excluirContato(widget.contato.id);
      _contatoService.adicionarContato(novoContato);
      Navigator.pop(context, true);
    }
  }


  void _excluirContato() {
    _contatoService.excluirContato(widget.contato.id);
    Navigator.pop(context, true);
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _telefoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}