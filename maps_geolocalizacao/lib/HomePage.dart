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
  CameraPosition _cameraPosition = CameraPosition(
      target: LatLng(-23.565160, -46.651797),
      zoom: 19
  );

  _getCurrentLocation() async {

    Position position = await Geolocator().getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
    );

    setState(() {
      _cameraPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 17
      );
      _moveCamera();
    });

  }

  _monitoringUserLocation(){

    var geolocator = Geolocator();
    var locationOptions = LocationOptions(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10
    );
    geolocator.getPositionStream( locationOptions )
        .listen((Position position){

      Marker userMarker = Marker(
          markerId: MarkerId("marcador-usuario"),
          position: LatLng(position.latitude, position.longitude),
          infoWindow: InfoWindow(
              title: "Meu local"
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueMagenta
          ),
          onTap: (){
            print("Meu local clicado!!");
          }
        //rotation: 45
      );

      setState(() {
        //-23.566989, -46.649598
        //-23.568395, -46.648353
        //_marcadores.add( marcadorUsuario );
        _cameraPosition = CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 17
        );
        _moveCamera();

      });

    });

  }

  _onMapCreated(GoogleMapController googleMapController){
    _controller.complete(googleMapController);
  }

  _moveCamera() async {

    GoogleMapController googleMapController = await _controller.future;
    googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
            _cameraPosition
        )
    );

  }

  @override
  void initState() {
    super.initState();
    _monitoringUserLocation();
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
          initialCameraPosition: _cameraPosition,
          onMapCreated: _onMapCreated,
          myLocationEnabled: true,
        ),
      ),
    );

  }

}