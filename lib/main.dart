import 'package:clienteflutter/homepage.dart';
import 'package:clienteflutter/pages/login/login.dart';
import 'package:clienteflutter/pages/login/registrar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(),
        '/login': (context) => const LoginCliente(),
        '/register': (context) => const Registrar(),
      },
    );
  }
}
