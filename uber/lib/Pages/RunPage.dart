/*
  Sabrina Karen
*/

import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber/Data/UserData.dart';
import 'package:uber/Utils/RequestStatus.dart';
import 'package:uber/Utils/UserOfFirebase.dart';

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
  Map<String, dynamic> _requestData;
  Position _driverLocal;

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

      setState(() {
        _driverLocal = position;
      });

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
        _driverLocal = position;
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

  _getRequest() async {

    String requestId = widget.requestId;

    Firestore db = Firestore.instance;
    DocumentSnapshot documentSnapshot = await db
        .collection("requisicoes")
        .document(requestId)
        .get();

    _requestData = documentSnapshot.data;
    _addListenerOfRequest();

  }

  _getTest() async {

    String requestId = widget.requestId;

    Firestore db = Firestore.instance;
    DocumentSnapshot documentSnapshot = await db
        .collection("requisicoes")
        .document(requestId)
        .get();

    _requestData = documentSnapshot.data;

  }

  _addListenerOfRequest() async {

    Firestore db = Firestore.instance;
    String requestId = _requestData["id"];
    await db.collection("requisicoes")
        .document(requestId).snapshots().listen((snapshot){

      if(snapshot.data != null){

        Map<String, dynamic> data = snapshot.data;
        String status = data["status"];

        switch(status){
          case RequestStatus.AGUARDANDO :
            _statusWaiting();
            break;
          case RequestStatus.A_CAMINHO :
            _statusOnTheWay();
            break;
          case RequestStatus.VIAGEM :

            break;
          case RequestStatus.FINALIZADA :

            break;
        }

      }

    });

  }

  _statusWaiting() {

    _changeMainButton(
        "Aceitar corrida",
        Color(0xff1ebbd8),
            () {_acceptRun();}
    );

  }

  _statusOnTheWay() {

    _changeMainButton(
        "A caminho do passageiro",
        Colors.grey,
        null
    );

    double passengerLatitude = _requestData["passageiro"]["latitude"];
    double passengerLongitude = _requestData["passageiro"]["longitude"];

    double driverLatitude = _requestData["motorista"]["latitude"];
    double driverLongitude = _requestData["motorista"]["longitude"];

    _showTwoMarkers(
        LatLng(driverLatitude, driverLongitude),
        LatLng(passengerLatitude, passengerLongitude)
    );

  }

  _showTwoMarkers(LatLng driverLatLng, LatLng passengerLatLng){

    double pixelRatio = MediaQuery.of(context).devicePixelRatio;

    Set<Marker> _markersList = {};
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: pixelRatio),
        "images/motorista.png")
        .then((BitmapDescriptor icone) {
      Marker marker1 = Marker(
          markerId: MarkerId("marcador-motorista"),
          position: LatLng(driverLatLng.latitude, driverLatLng.longitude),
          infoWindow: InfoWindow(title: "Local motorista"),
          icon: icone);
      _markersList.add(marker1);
    });

    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: pixelRatio),
        "images/passageiro.png")
        .then((BitmapDescriptor icone) {
      Marker marker2 = Marker(
          markerId: MarkerId("marcador-passageiro"),
          position: LatLng(passengerLatLng.latitude, passengerLatLng.longitude),
          infoWindow: InfoWindow(title: "Local passageiro"),
          icon: icone);
      _markersList.add(marker2);
    });

    setState(() {
      _markers = _markersList;
      _moveCamera(CameraPosition(
          target: LatLng(driverLatLng.latitude, driverLatLng.longitude),
          zoom: 18
      ));
    });

  }

  _acceptRun() async {

    // recuperar dados do motorista
    UserData driver = await UserOfFirebase.getUserLoggedInfo();
    driver.latitude = _driverLocal.latitude;
    driver.longitude = _driverLocal.longitude;

    Firestore db = Firestore.instance;
    String requestId = _requestData["id"];

    db.collection("requisicoes")
        .document(requestId).updateData({
      "motorista" : driver.toMap(),
      "status" : RequestStatus.A_CAMINHO,
    }).then((_){

      // atualiza requisicao ativa
      String passengerId = _requestData["passageiro"]["idUsuario"];
      db.collection("requisicao_ativa")
          .document(passengerId).updateData({
        "status" : RequestStatus.A_CAMINHO,
      });

      // salvar requisicao ativa para motorista
      String driverId = driver.userId;
      db.collection("requisicao_ativa_motorista")
          .document(driverId)
          .setData({
        "id_requisicao" : requestId,
        "id_usuario" : driverId,
        "status" : RequestStatus.A_CAMINHO,
      });

      // teste
      _getTest();

    });

  }

  @override
  void initState() {
    super.initState();
    _getLastKnownLocation();
    _addListenerOfLocalization();
    _getRequest();
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