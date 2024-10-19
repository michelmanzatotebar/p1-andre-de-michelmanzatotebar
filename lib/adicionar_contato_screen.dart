import 'package:agenda_contatos/main.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Por favor, insira o nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _telefoneController,
                decoration: InputDecoration(labelText: 'Telefone'),
                inputFormatters: [_telefoneMask],
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Por favor, insira o telefone';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Por favor, insira o email';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    await globalDb.insert('contatos', {
                      'nome': _nomeController.text,
                      'telefone': _telefoneController.text,
                      'email': _emailController.text,
                    });
                    Navigator.pop(context);
                  }
                },
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}