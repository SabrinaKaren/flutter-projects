/*
  Sabrina Karen
 */

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PassengerPage extends StatefulWidget {
  @override
  _PassengerPageState createState() => _PassengerPageState();
}

class _PassengerPageState extends State<PassengerPage> {

  List<String> menuItems = [
    "Configurações", "Deslogar"
  ];
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition _cameraPosition = CameraPosition(
      target: LatLng(-19.931824, -43.935333)
  );
  Set<Marker> _markers = {};

  _logoutUser() async {

    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.signOut();
    Navigator.pushReplacementNamed(context, "/");

  }

  _choiceOfMenu(String choice){

    switch(choice){
      case "Deslogar" :
        _logoutUser();
        break;
      case "Configurações" :

        break;
    }

  }

  _getLastKnownLocation() async {

    Position position = await Geolocator()
        .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      if(position != null){

        _showPassengerMarker(position);

        _cameraPosition = CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 19
        );

        _moveCamera(_cameraPosition);

      }
    });

  }

  _moveCamera(CameraPosition cameraPosition) async {

    GoogleMapController googleMapController = await _controller.future;
    googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
            cameraPosition
        )
    );

  }

  _addListenerOfLocalization(){

    var geolocator = Geolocator();
    var locationOptions = LocationOptions(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10
    );

    geolocator.getPositionStream(locationOptions).listen((Position position){

      _showPassengerMarker(position);

      _cameraPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 19
      );

      _moveCamera(_cameraPosition);

    });

  }

  _showPassengerMarker(Position local) async {

    double pixelRatio = MediaQuery.of(context).devicePixelRatio;

    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: pixelRatio),
        "images/passageiro.png"
    ).then((BitmapDescriptor icone){

      Marker passengerMarker = Marker(
          markerId: MarkerId("marcador-passageiro"),
          position: LatLng(local.latitude, local.longitude),
          infoWindow: InfoWindow(
              title: "Meu local"
          ),
          icon: icone
      );

      setState(() {
        _markers.add(passengerMarker);
      });

    });

  }

  _onMapCreated(GoogleMapController controller){
    _controller.complete(controller);
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
        title: Text("Painel passageiro"),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _choiceOfMenu,
            itemBuilder: (context){

              return menuItems.map((String item){

                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );

              }).toList();

            },
          )
        ],
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
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.white
                  ),
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                        icon: Container(
                          margin: EdgeInsets.only(left: 20),
                          width: 10,
                          height: 10,
                          child: Icon(Icons.location_on, color: Colors.green,),
                        ),
                        hintText: "Meu local",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 15, top: 16)
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 55,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.white
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                        icon: Container(
                          margin: EdgeInsets.only(left: 20),
                          width: 10,
                          height: 10,
                          child: Icon(Icons.local_taxi, color: Colors.black,),
                        ),
                        hintText: "Digite o destino",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 15, top: 16)
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              left: 0,
              bottom: 0,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: RaisedButton(
                    child: Text(
                      "Chamar Uber",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    color: Color(0xff1ebbd8),
                    padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    onPressed: (){

                    }
                ),
              ),
            )
          ],
        ),
      ),
    );

  }

}