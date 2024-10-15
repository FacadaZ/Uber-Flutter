import 'package:clienteflutter/homepage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Registrar extends StatefulWidget {
  const Registrar({super.key});

  @override
  _RegistrarState createState() => _RegistrarState();
}

class _RegistrarState extends State<Registrar> {
  final _formKey = GlobalKey<FormState>();
  final Uri _baseUrl = Uri.parse('http://143.198.16.180/api/auth');
  final Map<String, String> _registrarData = {
    'fullname': '',
    'email': '',
    'password': '',
  };

  Future<void> _registrarCliente() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    try {
      await register(_registrarData['fullname']!, _registrarData['email']!,
          _registrarData['password']!);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage()),
      );
    } catch (e) {
      print('Error during registration: $e');
      // Aquí puedes mostrar un mensaje de error al usuario si lo deseas
    }
  }

  Future<void> register(String fullname, String email, String password) async {
    final url = Uri.parse('$_baseUrl/registeruser');
    final response = await http.post(url, body: {
      'fullname': fullname,
      'email': email,
      'password': password,
    });

    if (response.statusCode != 201) {
      final jsonResponse = json.decode(response.body);
      final String errorMessage =
          jsonResponse['error'] ?? 'Unknown error occurred';
      throw Exception('Failed to register: $errorMessage');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro Cliente')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Fullname'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Ingrese su nombre completo';
                  }
                  return null;
                },
                onSaved: (value) {
                  _registrarData['fullname'] = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Ingrese su email';
                  }
                  return null;
                },
                onSaved: (value) {
                  _registrarData['email'] = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Ingrese su contraseña';
                  }
                  return null;
                },
                onSaved: (value) {
                  _registrarData['password'] = value!;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _registrarCliente,
                child: const Text('Registrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
