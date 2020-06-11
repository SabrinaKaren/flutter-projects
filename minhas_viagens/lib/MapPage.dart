/*
  Sabrina Karen
 */
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  CameraPosition _cameraPosition = CameraPosition(
      target: LatLng(-19.919185, -43.938747),
      zoom: 18
  );
  Firestore _db = Firestore.instance;

  _onMapCreated(GoogleMapController controller){
    _controller.complete(controller);
  }

  _addMarker(LatLng latLng) async {

    List<Placemark> addressList = await Geolocator()
        .placemarkFromCoordinates(latLng.latitude, latLng.longitude);

    if (addressList != null && addressList.length > 0){

      Placemark address = addressList[0];
      String street = address.thoroughfare;

      Marker marker = Marker(
          markerId: MarkerId("marcador-${latLng.latitude}-${latLng.longitude}"),
          position: latLng,
          infoWindow: InfoWindow(
              title: street
          )
      );

      setState(() {

        _markers.add(marker);

        // salvar no firestore
        Map<String, dynamic> trip = Map();
        trip["titulo"] = street;
        trip["latitude"] = latLng.latitude;
        trip["longitude"] = latLng.longitude;

        _db.collection("viagens").add(trip);

      });

    }

  }

  _moveCamera() async {

    GoogleMapController googleMapController = await _controller.future;
    googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
            _cameraPosition
        )
    );

  }

  _monitoringUserLocation(){

    var geolocator = Geolocator();
    var locationOptions = LocationOptions(accuracy: LocationAccuracy.high);
    geolocator.getPositionStream( locationOptions ).listen((Position position){

      setState(() {
        _cameraPosition = CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 18
        );
        _moveCamera();
      });

    });

  }

  @override
  void initState() {
    super.initState();
    _monitoringUserLocation();
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
          initialCameraPosition: _cameraPosition,
          onMapCreated: _onMapCreated,
          onLongPress: _addMarker,
        ),
      ),
    );

  }

}