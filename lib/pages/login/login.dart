import 'package:clienteflutter/pages/lista_viajes/lista_cliente.dart';
import 'package:clienteflutter/providers/providers.dart';
import 'package:flutter/material.dart';

class LoginCliente extends StatefulWidget {
  const LoginCliente({super.key});

  @override
  _LoginClienteState createState() => _LoginClienteState();
}

class _LoginClienteState extends State<LoginCliente> {
  final _formKey = GlobalKey<FormState>();
  final ApiProvider _apiProvider = ApiProvider();
  final Map<String, String> _loginData = {
    'email': '',
    'password': '',
  };

  void LoginCliente() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    final token =
        await _apiProvider.login(_loginData['email']!, _loginData['password']!);
    if (token != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ListasCliente()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Inicio de sesión exitoso')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Inicio de sesión fallido')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Driver')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'ingrese su email';
                  }
                  return null;
                },
                onSaved: (value) {
                  _loginData['email'] = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'ingrese su password';
                  }
                  return null;
                },
                onSaved: (value) {
                  _loginData['password'] = value!;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: LoginCliente,
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
