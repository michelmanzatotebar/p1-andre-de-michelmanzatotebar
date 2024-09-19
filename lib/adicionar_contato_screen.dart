import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'contato_model.dart';
import 'contato_service.dart';

class AdicionarContatoScreen extends StatefulWidget {
  @override
  _AdicionarContatoScreenState createState() => _AdicionarContatoScreenState();
}

class _AdicionarContatoScreenState extends State<AdicionarContatoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _emailController = TextEditingController();
  final ContatoService _contatoService = ContatoService();

  final _telefoneMask = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Contato'),
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
                inputFormatters: [_telefoneMask],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um telefone';
                  }
                  if (value.length < 14) {
                    return 'Telefone inválido';
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
            ],
          ),
        ),
      ),
    );
  }

  void _salvarContato() async {
    if (_formKey.currentState!.validate()) {
      Contato novoContato = Contato(
        nome: _nomeController.text,
        telefone: _telefoneController.text,
        email: _emailController.text,
      );
      await _contatoService.adicionarContato(novoContato);
      Navigator.pop(context, true);
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _telefoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}