/*
  Sabrina Karen
 */

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Completer<GoogleMapController> _controller = Completer();

  _onMapCreated(GoogleMapController googleMapController){
    _controller.complete(googleMapController);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Mapas e geolocalização"),),
      body: Container(
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
              target: LatLng(-23.562436, -46.655005),
              zoom: 16
          ),
          onMapCreated: _onMapCreated,
        ),
      ),
    );

  }

}