import 'package:agenda_contatos/main.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'contato_model.dart';
import 'contato_service.dart';

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

  final _telefoneMask = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        await globalDb.update(
                          'contatos',
                          {
                            'nome': _nomeController.text,
                            'telefone': _telefoneController.text,
                            'email': _emailController.text,
                          },
                          where: 'id = ?',
                          whereArgs: [widget.contato.id],
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Salvar'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await globalDb.delete(
                        'contatos',
                        where: 'id = ?',
                        whereArgs: [widget.contato.id],
                      );
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: Text('Excluir'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}