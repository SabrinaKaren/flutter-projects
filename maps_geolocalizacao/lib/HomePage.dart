/*
  Sabrina Karen
 */

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  Set<Polygon> _polygons  = {};
  Set<Polyline> _polylines  = {};

  _getCurrentLocation() async {

    Position position = await Geolocator().getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
    );

  }

  _onMapCreated(GoogleMapController googleMapController){
    _controller.complete(googleMapController);
  }

  _moveCamera() async {

    GoogleMapController googleMapController = await _controller.future;
    googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(-23.562436, -46.655005),
                zoom: 16,
                tilt: 0,
                bearing: 270
            )
        )
    );

  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Mapas e geolocalização"),),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: FloatingActionButton(
        onPressed: _moveCamera,
        child: Icon (Icons.done),
      ),
      body: Container(
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
              target: LatLng(-23.562436, -46.655005),
              zoom: 16
          ),
          onMapCreated: _onMapCreated,
          markers: _markers,
          polygons: _polygons,
          polylines: _polylines,
        ),
      ),
    );

  }

}