import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const Mapas());
}

class Mapas extends StatelessWidget {
  const Mapas({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MapScreen(),
      ),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {}

  void _onMapTapped(LatLng position) {
    final String markerIdVal = 'marker_${_markers.length}';
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(markerIdVal),
          position: position,
          onTap: () {
            setState(() {
              _markers.removeWhere((marker) => marker.markerId.value == markerIdVal);
            });
          },
        ),
      );
    });

    // Imprimir las coordenadas de todos los marcadores
    _markers.forEach((marker) {
      print('Marker: ${marker.markerId.value}, Position: ${marker.position.latitude}, ${marker.position.longitude}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: const CameraPosition(
        target: LatLng(-17.769018, -63.182633),
        zoom: 18.0,
      ),
      markers: _markers,
      onTap: _onMapTapped,
    );
  }
}
