/*
  Sabrina Karen
 */
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};

  _onMapCreated(GoogleMapController controller){
    _controller.complete(controller);
  }

  _showMarker(LatLng latLng){

    Marker marker = Marker(
        markerId: MarkerId("marcador-${latLng.latitude}-${latLng.longitude}"),
        position: latLng,
        infoWindow: InfoWindow(
            title: "Marcador"
        )
    );

    setState(() {
      _markers.add(marker);
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Mapa"),
      ),
      body: Container(
        child: GoogleMap(
          markers: _markers,
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
              target: LatLng(-19.919185, -43.938747),
              zoom: 18
          ),
          onMapCreated: _onMapCreated,
          onLongPress: _showMarker,
        ),
      ),
    );

  }

}