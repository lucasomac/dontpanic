import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';

import '../../data/models/secure_contact.dart';
import '../../data/repository/secure_contact_repository.dart';

class SecureContactForm extends StatefulWidget {
  final String userEmail;

  const SecureContactForm(this.userEmail, {Key? key}) : super(key: key);

  @override
  State<SecureContactForm> createState() => _SecureContactFormState();
}

class _SecureContactFormState extends State<SecureContactForm> {
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};
  final SecureContactRepository repository = KiwiContainer().resolve();

  // void _loadFormData(User user) {
  //   _formData['id'] = user.id!;
  //   _formData['name'] = user.name;
  //   _formData['email'] = user.email;
  //   _formData['avatarUrl'] = user.avatarUrl!;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Formulário de cadastro',
          style: TextStyle(color: Colors.black54),
        ),
        backgroundColor: Colors.white70,
        actions: [
          IconButton(
              onPressed: () {
                if (_form.currentState!.validate()) {
                  _form.currentState!.save();
                  repository.addSecureContact(widget.userEmail,
                      SecureContact(_formData['name']!, _formData['phone']!));
                  Navigator.of(context).pop();
                }
              },
              icon: const Icon(
                Icons.save,
                color: Colors.black54,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                initialValue: _formData['name'],
                decoration: const InputDecoration(
                  label: Text('Nome'),
                  labelStyle: TextStyle(color: Colors.green),
                  icon: Icon(
                    Icons.person,
                    color: Colors.greenAccent,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.greenAccent),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Não pode ser vazio ou nulo';
                  }
                  if (value.trim().length < 3) {
                    return 'Tamanho do nome não pode ser menor que 3';
                  }
                  return null;
                },
                onSaved: (value) => _formData['name'] = value!,
              ),
              TextFormField(
                initialValue: _formData['phone'],
                decoration: const InputDecoration(
                    label: Text('Telefone'),
                    labelStyle: TextStyle(color: Colors.green),
                    icon: Icon(
                      Icons.phone,
                      color: Colors.greenAccent,
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.greenAccent))),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Telefone não pode ser vazio ou nulo';
                  }
                  if (value.length != 12) {
                    return 'Telefone deve ter tamanho 12 no formato DDD+XXXXXXXXX';
                  }
                  return null;
                },
                onSaved: (value) => _formData['phone'] = value!,
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }
}
