/*
  Sabrina Karen
*/

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RunPage extends StatefulWidget {

  String requestId;
  RunPage(this.requestId);

  @override
  _RunPageState createState() => _RunPageState();

}

class _RunPageState extends State<RunPage> {

  Completer<GoogleMapController> _controller = Completer();
  CameraPosition _cameraPosition = CameraPosition(
      target: LatLng(-19.931824, -43.935333)
  );
  Set<Marker> _markers = {};

  // controles para exibição na tela
  String _buttonText = "Aceitar corrida";
  Color _buttonColor = Color(0xff1ebbd8);
  Function _buttonFunction;

  _changeMainButton(String text, Color color, Function function) {
    setState(() {
      _buttonText = text;
      _buttonColor = color;
      _buttonFunction = function;
    });
  }

  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  _addListenerOfLocalization() {

    var geolocator = Geolocator();
    var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

    geolocator.getPositionStream(locationOptions).listen((Position position) {
      _showPassengerMarker(position);
      _cameraPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 19
      );
      _moveCamera(_cameraPosition);
    });

  }

  _getLastKnownLocation() async {

    Position position = await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      if (position != null) {
        _showPassengerMarker(position);
        _cameraPosition = CameraPosition(
            target: LatLng(position.latitude,
                position.longitude), zoom: 19
        );
        _moveCamera(_cameraPosition);
      }
    });

  }

  _moveCamera(CameraPosition cameraPosition) async {
    GoogleMapController googleMapController = await _controller.future;
    googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(cameraPosition)
    );
  }

  _showPassengerMarker(Position local) async {

    double pixelRatio = MediaQuery.of(context).devicePixelRatio;

    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: pixelRatio),
        "images/motorista.png")
        .then((BitmapDescriptor icone) {
      Marker passengerMarker = Marker(
          markerId: MarkerId("marcador-motorista"),
          position: LatLng(local.latitude, local.longitude),
          infoWindow: InfoWindow(title: "Meu local"),
          icon: icone);

      setState(() {
        _markers.add(passengerMarker);
      });

    });
  }

  @override
  void initState() {
    super.initState();
    _getLastKnownLocation();
    _addListenerOfLocalization();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Painel corrida"),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _cameraPosition,
              onMapCreated: _onMapCreated,
              //myLocationEnabled: true,
              myLocationButtonEnabled: false,
              markers: _markers,
              //-23,559200, -46,658878
            ),
            Positioned(
              right: 0,
              left: 0,
              bottom: 0,
              child: Padding(
                padding: Platform.isIOS
                    ? EdgeInsets.fromLTRB(20, 10, 20, 25)
                    : EdgeInsets.all(10),
                child: RaisedButton(
                    child: Text(
                      _buttonText,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    color: _buttonColor,
                    padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    onPressed: _buttonFunction),
              ),
            )
          ],
        ),
      ),
    );

  }

}