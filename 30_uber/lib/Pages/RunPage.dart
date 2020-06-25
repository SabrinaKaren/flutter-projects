/*
  Sabrina Karen
*/

import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
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
  String _statusMsg = "";
  String _requestId;
  String _requestStatus = RequestStatus.AGUARDANDO;
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

      if(position != null){

        if(_requestId != null && _requestId.isNotEmpty){

          if(_requestStatus != RequestStatus.AGUARDANDO){

            UserOfFirebase.updateLocationData(
                _requestId,
                position.latitude,
                position.longitude
            );

          }else{

            setState(() {
              _driverLocal = position;
            });
            _statusWaiting();

          }

        }

      }

    });
  }

  _getLastKnownLocation() async {

    Position position = await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);

    if (position != null) {

    }

  }

  _moveCamera(CameraPosition cameraPosition) async {
    GoogleMapController googleMapController = await _controller.future;
    googleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  _showMarker(Position local, String icon, String infoWindow) async {

    double pixelRatio = MediaQuery.of(context).devicePixelRatio;

    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: pixelRatio),
        icon
    )
        .then((BitmapDescriptor bitmapDescriptor) {

      Marker marker = Marker(
          markerId: MarkerId(icon),
          position: LatLng(local.latitude, local.longitude),
          infoWindow: InfoWindow(title: infoWindow),
          icon: bitmapDescriptor);

      setState(() {
        _markers.add(marker);
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

  }

  _addListenerOfRequest() async {

    Firestore db = Firestore.instance;

    await db.collection("requisicoes")
        .document(_requestId).snapshots().listen((snapshot){

      if(snapshot.data != null){

        _requestData = snapshot.data;

        Map<String, dynamic> data = snapshot.data;
        _requestStatus = data["status"];

        switch(_requestStatus){

          case RequestStatus.AGUARDANDO :
            _statusWaiting();
            break;
          case RequestStatus.A_CAMINHO :
            _statusOnTheWay();
            break;
          case RequestStatus.VIAGEM :
            _statusOnTrip();
            break;
          case RequestStatus.FINALIZADA :
            _statusFinished();
            break;
          case RequestStatus.CONFIRMADA :
            _statusConfirmed();
            break;

        }

      }

    });

  }

  _statusWaiting() {

    _changeMainButton(
        "Aceitar corrida",
        Color(0xff1ebbd8),
            () {
          _acceptRun();
        });

    if(_driverLocal != null){

      double driverLat = _driverLocal.latitude;
      double driverLon = _driverLocal.longitude;

      Position position = Position(
          latitude: driverLat, longitude: driverLon
      );

      _showMarker(
          position,
          "images/motorista.png",
          "Motorista"
      );

      CameraPosition cameraPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 19
      );

      _moveCamera(cameraPosition);

    }

  }

  _statusOnTheWay() {

    _statusMsg = "A caminho do passageiro";

    _changeMainButton(
        "Iniciar corrida",
        Color(0xff1ebbd8),
            (){
          _startRun();
        }
    );

    double driverLat = _requestData["motorista"]["latitude"];
    double driverLon = _requestData["motorista"]["longitude"];

    double passengerLat = _requestData["passageiro"]["latitude"];
    double passengerLon = _requestData["passageiro"]["longitude"];

    _showTwoMarkers(
        LatLng(driverLat, driverLon),
        LatLng(passengerLat, passengerLon)
    );

    var nLat, nLon, sLat, sLon;

    if(driverLat <=  passengerLat){
      sLat = driverLat;
      nLat = passengerLat;
    }else{
      sLat = passengerLat;
      nLat = driverLat;
    }

    if(driverLon <=  passengerLon){
      sLon = driverLon;
      nLon = passengerLon;
    }else{
      sLon = driverLon;
      nLon = passengerLon;
    }

    _moveCameraBounds(
        LatLngBounds(
            northeast: LatLng(nLat, nLon),
            southwest: LatLng(sLat, sLon)
        )
    );

  }

  _finishRun(){

    Firestore db = Firestore.instance;
    db.collection("requisicoes")
        .document(_requestId)
        .updateData({
      "status" : RequestStatus.FINALIZADA
    });

    String passengerId = _requestData["passageiro"]["idUsuario"];
    db.collection("requisicao_ativa")
        .document(passengerId)
        .updateData({"status": RequestStatus.FINALIZADA });

    String driverId = _requestData["motorista"]["idUsuario"];
    db.collection("requisicao_ativa_motorista")
        .document(driverId)
        .updateData({"status": RequestStatus.FINALIZADA });

  }

  _statusFinished() async {

    double originLat = _requestData["origem"]["latitude"];
    double originLon = _requestData["origem"]["longitude"];

    double destinationLat = _requestData["destino"]["latitude"];
    double destinationLon = _requestData["destino"]["longitude"];

    double distanceInMeters = await Geolocator().distanceBetween(
        originLat,
        originLon,
        destinationLat,
        destinationLon
    );

    // converter para km
    double distanceInKm = distanceInMeters / 1000;

    // 8 é o valor cobrado por km
    double tripPrice = distanceInKm * 8;

    // formatando o valor da viagem
    var f = new NumberFormat("#,##0.00", "pt_BR");
    var tripPriceFormatted = f.format(tripPrice);

    _statusMsg = "Viagem finalizada";
    _changeMainButton(
        "Confirmar - R\$ ${tripPriceFormatted}",
        Color(0xff1ebbd8),
            (){
          _confirmRun();
        }
    );

    _markers = {};
    Position position = Position(
        latitude: destinationLat, longitude: destinationLon
    );

    _showMarker(
        position,
        "images/destino.png",
        "Destino"
    );

    CameraPosition cameraPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 19
    );

    _moveCamera(cameraPosition);

  }

  _statusConfirmed(){
    Navigator.pushReplacementNamed(context, "/motorista");
  }

  _confirmRun(){

    Firestore db = Firestore.instance;
    db.collection("requisicoes")
        .document(_requestId)
        .updateData({
      "status" : RequestStatus.CONFIRMADA
    });

    String passengerId = _requestData["passageiro"]["idUsuario"];
    db.collection("requisicao_ativa")
        .document(passengerId)
        .delete();

    String driverId = _requestData["motorista"]["idUsuario"];
    db.collection("requisicao_ativa_motorista")
        .document(driverId)
        .delete();

  }

  _statusOnTrip() {

    _statusMsg = "Em viagem";

    _changeMainButton(
        "Finalizar corrida",
        Color(0xff1ebbd8),
            (){
          _finishRun();
        }
    );

    double originLat = _requestData["motorista"]["latitude"];
    double originLon = _requestData["motorista"]["longitude"];

    double destinationLat = _requestData["destino"]["latitude"];
    double destinationLon = _requestData["destino"]["longitude"];

    _showTwoMarkers(
        LatLng(originLat, originLon),
        LatLng(destinationLat, destinationLon)
    );

    var nLat, nLon, sLat, sLon;

    if(originLat <=  destinationLat){
      sLat = originLat;
      nLat = destinationLat;
    }else{
      sLat = destinationLat;
      nLat = originLat;
    }

    if(originLon <=  destinationLon){
      sLon = originLon;
      nLon = destinationLon;
    }else{
      sLon = destinationLon;
      nLon = originLon;
    }

    _moveCameraBounds(
        LatLngBounds(
            northeast: LatLng(nLat, nLon),
            southwest: LatLng(sLat, sLon)
        )
    );

  }

  _startRun(){

    Firestore db = Firestore.instance;
    db.collection("requisicoes")
        .document(_requestId)
        .updateData({
      "origem" : {
        "latitude" : _requestData["motorista"]["latitude"],
        "longitude" : _requestData["motorista"]["longitude"]
      },
      "status" : RequestStatus.VIAGEM
    });

    String passengerId = _requestData["passageiro"]["idUsuario"];
    db.collection("requisicao_ativa")
        .document(passengerId)
        .updateData({"status": RequestStatus.VIAGEM });

    String driverId = _requestData["motorista"]["idUsuario"];
    db.collection("requisicao_ativa_motorista")
        .document(driverId)
        .updateData({"status": RequestStatus.VIAGEM });

  }

  _moveCameraBounds(LatLngBounds latLngBounds) async {

    GoogleMapController googleMapController = await _controller.future;
    googleMapController
        .animateCamera(
        CameraUpdate.newLatLngBounds(
            latLngBounds,
            100
        )
    );

  }

  _showTwoMarkers(LatLng driverLatLng, LatLng passengerLatLng){

    double pixelRatio = MediaQuery.of(context).devicePixelRatio;

    Set<Marker> _markersList = {};

    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: pixelRatio),
        "images/motorista.png")
        .then((BitmapDescriptor icon) {

      Marker marker1 = Marker(
          markerId: MarkerId("marcador-motorista"),
          position: LatLng(driverLatLng.latitude, driverLatLng.longitude),
          infoWindow: InfoWindow(title: "Local motorista"),
          icon: icon);
      _markersList.add(marker1);

    });

    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: pixelRatio),
        "images/passageiro.png")
        .then((BitmapDescriptor icon) {

      Marker marker2 = Marker(
          markerId: MarkerId("marcador-passageiro"),
          position: LatLng(passengerLatLng.latitude, passengerLatLng.longitude),
          infoWindow: InfoWindow(title: "Local passageiro"),
          icon: icon);
      _markersList.add(marker2);

    });

    setState(() {
      _markers = _markersList;
    });

  }

  _acceptRun() async {

    UserData driver = await UserOfFirebase.getUserLoggedInfo();
    driver.latitude = driver.latitude;
    driver.longitude = driver.longitude;

    Firestore db = Firestore.instance;
    String requestId = _requestData["id"];

    db.collection("requisicoes")
        .document(requestId).updateData({
      "motorista" : driver.toMap(),
      "status" : RequestStatus.A_CAMINHO,
    }).then((_){

      String passengerId = _requestData["passageiro"]["idUsuario"];
      db.collection("requisicao_ativa")
          .document(passengerId).updateData({
        "status" : RequestStatus.A_CAMINHO,
      });

      String driverId = driver.userId;
      db.collection("requisicao_ativa_motorista")
          .document(driverId)
          .setData({
        "id_requisicao" : requestId,
        "id_usuario" : driverId,
        "status" : RequestStatus.A_CAMINHO,
      });

    });

  }

  @override
  void initState() {
    super.initState();
    _requestId = widget.requestId;
    _addListenerOfRequest();
    _addListenerOfLocalization();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Painel corrida - " + _statusMsg),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _cameraPosition,
              onMapCreated: _onMapCreated,
              myLocationButtonEnabled: false,
              markers: _markers,
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
                    onPressed: _buttonFunction
                ),
              ),
            )
          ],
        ),
      ),
    );

  }

}