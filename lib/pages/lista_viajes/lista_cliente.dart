import 'dart:convert';

import 'package:clienteflutter/models/viaje_obtenido.dart';
import 'package:clienteflutter/pages/maps/mapas.dart';
import 'package:clienteflutter/providers/cliente.dart';
import 'package:flutter/material.dart';

class ListasCliente extends StatefulWidget {
  const ListasCliente({super.key});

  @override
  _ListasClienteState createState() => _ListasClienteState();
}

class _ListasClienteState extends State<ListasCliente> {
  late final ClienteService clienteService;
  List<ViajeObtenido> _trips = [];

  @override
  void initState() {
    super.initState();
    clienteService = ClienteService();
    _loadTrips();
  }

  Future<void> _loadTrips() async {
    try {
      String tripsJson = await clienteService.getTrips();
      final List<dynamic> parsedJson = jsonDecode(tripsJson);
      final List<ViajeObtenido> trips =
          parsedJson.map((json) => ViajeObtenido.fromJson(json)).toList();
      setState(() {
        _trips = trips;
      });
    } catch (e) {
      print('Error loading trips: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Viajes Solicitados'),
      ),
      body: ListView.builder(
        itemCount: _trips.length,
        itemBuilder: (context, index) {
          final trip = _trips[index];
          return InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Seleccionaste el viaje: ${trip.name}'),
                ),
              );
            },
            child: ListTile(
              title: Text('Trip Name: ${trip.name}'),
              subtitle: Text('Driver Name: ${trip.driver.fullname}, Hora: ${trip.startTime}'),
              
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => Mapas()),
          );
        },
        child: Icon(Icons.map),
      ),
    );
  }
}