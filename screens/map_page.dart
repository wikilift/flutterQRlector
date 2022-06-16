import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/scan_model.dart';

class MapPageScreen extends StatefulWidget {
  const MapPageScreen({Key? key}) : super(key: key);

  @override
  State<MapPageScreen> createState() => _MapPageScreenState();
}

class _MapPageScreenState extends State<MapPageScreen> {
  Completer<GoogleMapController> _controller = Completer();
  MapType map = MapType.normal;
  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context)?.settings.arguments as ScanModel;

    //marcadores
    Set<Marker> markers = <Marker>{};
    markers.add(Marker(
        infoWindow: const InfoWindow(title: 'Está aquí'),
        markerId: const MarkerId('geo-location'),
        position: scan.position));

    CameraPosition initialPoint = CameraPosition(target: scan.position, zoom: 17, tilt: 50);

    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(
                  CameraUpdate.newCameraPosition(CameraPosition(target: scan.position, zoom: 17, tilt: 50)));
            },
            icon: const Icon(Icons.location_history_sharp))
      ]),
      body: SafeArea(
        child: GoogleMap(
          markers: markers,
          mapType: map,
          initialCameraPosition: initialPoint,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (map == MapType.normal) {
            map = MapType.satellite;
          } else {
            map = MapType.normal;
          }

          setState(() {});
        },
        child: const Icon(Icons.layers),
      ),
    );
  }
}
