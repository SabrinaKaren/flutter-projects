/*
  Sabrina Karen
*/

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:uber/Data/DestinationData.dart';
import 'package:uber/Data/MarkerData.dart';
import 'package:uber/Data/RequestData.dart';
import 'package:uber/Data/UserData.dart';
import 'package:uber/Utils/RequestStatus.dart';
import 'package:uber/Utils/UserOfFirebase.dart';

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
  TextEditingController _controllerDestination  = TextEditingController(text: "av. Bias Fortes, 162");
  String _requestId;
  Position _passengerLocal;
  Map<String, dynamic> _requestData;
  StreamSubscription<DocumentSnapshot> _streamSubscriptionRequests;

  // controles para exibição na tela
  bool _showDestinationBox = true;
  String _buttonText = "Chamar uber";
  Color _buttonColor = Color(0xff1ebbd8);
  Function _buttonFunction;

  _logoutUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushReplacementNamed(context, "/");
  }

  _choiceOfMenu(String choice) {
    switch (choice) {
      case "Deslogar":
        _logoutUser();
        break;
      case "Configurações":
        break;
    }
  }

  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  _addListenerOfLocalization() {

    var geolocator = Geolocator();
    var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

    geolocator.getPositionStream(locationOptions).listen((Position position) {

      if(_requestId != null && _requestId.isNotEmpty){

        UserOfFirebase.updateLocationData(
            _requestId,
            position.latitude,
            position.longitude
        );

      }else{
        setState(() {
          _passengerLocal = position;
        });
        _statusNotCalled();
      }

    });

  }

  _getLastKnownLocation() async {

    Position position = await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {

      if (position != null) {

        _showPassengerMarker(position);

        _cameraPosition = CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 19
        );

        _passengerLocal = position;
        _moveCamera(_cameraPosition);

      }

    });
  }

  _moveCamera(CameraPosition cameraPosition) async {
    GoogleMapController googleMapController = await _controller.future;
    googleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  _showPassengerMarker(Position local) async {

    double pixelRatio = MediaQuery.of(context).devicePixelRatio;

    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: pixelRatio),
        "images/passageiro.png")
        .then((BitmapDescriptor icon) {

      Marker passengerMarker = Marker(
          markerId: MarkerId("marcador-passageiro"),
          position: LatLng(local.latitude, local.longitude),
          infoWindow: InfoWindow(title: "Meu local"),
          icon: icon);

      setState(() {
        _markers.add(passengerMarker);
      });

    });

  }

  _callUber() async {

    String destinationAddress = _controllerDestination.text;

    if (destinationAddress.isNotEmpty) {

      List<Placemark> addressList = await Geolocator().placemarkFromAddress(destinationAddress);

      if (addressList != null && addressList.length > 0) {

        Placemark address = addressList[0];

        DestinationData destination = DestinationData();
        destination.city = address.subAdministrativeArea;
        destination.cep = address.postalCode;
        destination.neighborhood = address.subLocality;
        destination.street = address.thoroughfare;
        destination.number = address.subThoroughfare;
        destination.latitude = address.position.latitude;
        destination.longitude = address.position.longitude;

        String addressConfirmation;
        addressConfirmation = "\n Cidade: " + destination.city;
        addressConfirmation += "\n Rua: " + destination.street + ", " + destination.number;
        addressConfirmation += "\n Bairro: " + destination.neighborhood;
        addressConfirmation += "\n Cep: " + destination.cep;

        showDialog(
            context: context,
            builder: (contex) {
              return AlertDialog(
                title: Text("Confirmação do endereço"),
                content: Text(addressConfirmation),
                contentPadding: EdgeInsets.all(16),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      "Cancelar",
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () => Navigator.pop(contex),
                  ),
                  FlatButton(
                    child: Text(
                      "Confirmar",
                      style: TextStyle(color: Colors.green),
                    ),
                    onPressed: () {
                      _saveRequest(destination);
                      Navigator.pop(contex);
                    },
                  )
                ],
              );
            });

      }

    }

  }

  _saveRequest(DestinationData destination) async {

    UserData passenger = await UserOfFirebase.getUserLoggedInfo();
    passenger.latitude = _passengerLocal.latitude;
    passenger.longitude = _passengerLocal.longitude;

    RequestData request = RequestData();
    request.destination = destination;
    request.passenger = passenger;
    request.status = RequestStatus.AGUARDANDO;

    Firestore db = Firestore.instance;

    db
        .collection("requisicoes")
        .document(request.id)
        .setData(request.toMap());

    Map<String, dynamic> activeRequisitionData = {};
    activeRequisitionData["id_requisicao"] = request.id;
    activeRequisitionData["id_usuario"] = passenger.userId;
    activeRequisitionData["status"] = RequestStatus.AGUARDANDO;

    db
        .collection("requisicao_ativa")
        .document(passenger.userId)
        .setData(activeRequisitionData);

    if(_streamSubscriptionRequests == null){
      _addListenerOfRequest(request.id);
    }

  }

  _changeMainButton(String text, Color color, Function function) {
    setState(() {
      _buttonText = text;
      _buttonColor = color;
      _buttonFunction = function;
    });
  }

  _statusNotCalled() {

    _showDestinationBox = true;

    _changeMainButton("Chamar uber", Color(0xff1ebbd8), () {
      _callUber();
    });

    if(_passengerLocal != null){

      Position position = Position(
          latitude: _passengerLocal.latitude,
          longitude: _passengerLocal.longitude
      );

      _showPassengerMarker(position);

      CameraPosition cameraPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 19
      );

      _moveCamera(cameraPosition);

    }

  }

  _statusWaiting() {

    _showDestinationBox = false;

    _changeMainButton("Cancelar", Colors.red, () {
      _cancelUber();
    });

    double passengerLat = _requestData["passageiro"]["latitude"];
    double passengerLon = _requestData["passageiro"]["longitude"];
    Position position = Position(
        latitude: passengerLat,
        longitude: passengerLon
    );

    _showPassengerMarker(position);

    CameraPosition cameraPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 19
    );

    _moveCamera(cameraPosition);

  }

  _statusOnTheWay() {

    _showDestinationBox = false;

    _changeMainButton(
        "Motorista a caminho",
        Colors.grey,
            () {

        });

    double originLat = _requestData["motorista"]["latitude"];
    double originLon = _requestData["motorista"]["longitude"];

    double destinationLat = _requestData["passageiro"]["latitude"];
    double destinationLon = _requestData["passageiro"]["longitude"];

    MarkerData originMarker = MarkerData(
        LatLng(originLat, originLon),
        "images/motorista.png",
        "Local motorista"
    );

    MarkerData destinationMarker = MarkerData(
        LatLng(destinationLat, destinationLon),
        "images/passageiro.png",
        "Local destino"
    );

    _showAndCenterTwoMarkers(originMarker, destinationMarker);

  }

  _statusOnTrip() {

    _showDestinationBox = false;

    _changeMainButton(
        "Em viagem",
        Colors.grey,
        null
    );

    double originLat = _requestData["motorista"]["latitude"];
    double originLon = _requestData["motorista"]["longitude"];

    double destinationLat = _requestData["destino"]["latitude"];
    double destinationLon = _requestData["destino"]["longitude"];

    MarkerData originMarker = MarkerData(
        LatLng(originLat, originLon),
        "images/motorista.png",
        "Local motorista"
    );

    MarkerData destinationMarker = MarkerData(
        LatLng(destinationLat, destinationLon),
        "images/destino.png",
        "Local destino"
    );

    _showAndCenterTwoMarkers(originMarker, destinationMarker);

  }

  _showAndCenterTwoMarkers(MarkerData originMarker, MarkerData destinationMarker){

    double originLat = originMarker.local.latitude;
    double originLon = originMarker.local.longitude;

    double destinationLat = destinationMarker.local.latitude;
    double destinationLon = destinationMarker.local.longitude;

    _showTwoMarkers(
        originMarker,
        destinationMarker
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

  _statusFinished() async {

    double destinationLat = _requestData["destino"]["latitude"];
    double destinationLon = _requestData["destino"]["longitude"];

    double originLat = _requestData["origem"]["latitude"];
    double originLon = _requestData["origem"]["longitude"];

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

    _changeMainButton(
        "Total - R\$ ${tripPriceFormatted}",
        Colors.green,
            (){}
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

    if(_streamSubscriptionRequests != null)
      _streamSubscriptionRequests.cancel();

    _showDestinationBox = true;

    _changeMainButton(
        "Chamar uber",
        Color(0xff1ebbd8), () {
      _callUber();
    });

    _requestData = {};

  }

  _showMarker(Position local, String icon, String infoWindow) async {

    double pixelRatio = MediaQuery.of(context).devicePixelRatio;

    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: pixelRatio),
        icon)
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

  _showTwoMarkers(MarkerData originMarker, MarkerData destinationMarker){

    double pixelRatio = MediaQuery.of(context).devicePixelRatio;

    LatLng originLatLng = originMarker.local;
    LatLng destinationLatLng = destinationMarker.local;

    Set<Marker> _markersList = {};

    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: pixelRatio),
        originMarker.imagePath)
        .then((BitmapDescriptor icon) {

      Marker origin = Marker(
          markerId: MarkerId(originMarker.imagePath),
          position: LatLng(originLatLng.latitude, originLatLng.longitude),
          infoWindow: InfoWindow(title: originMarker.title),
          icon: icon);
      _markersList.add(origin);

    });

    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: pixelRatio),
        destinationMarker.imagePath)
        .then((BitmapDescriptor icon) {

      Marker destination = Marker(
          markerId: MarkerId(destinationMarker.imagePath),
          position: LatLng(destinationLatLng.latitude, destinationLatLng.longitude),
          infoWindow: InfoWindow(title: destinationMarker.title),
          icon: icon);
      _markersList.add(destination);

    });

    setState(() {
      _markers = _markersList;
    });

  }

  _cancelUber() async {

    FirebaseUser firebaseUser = await UserOfFirebase.getCurrentUser();

    Firestore db = Firestore.instance;
    db.collection("requisicoes")
        .document(_requestId).updateData({
      "status" : RequestStatus.CANCELADA
    }).then((_){

      db.collection("requisicao_ativa")
          .document(firebaseUser.uid)
          .delete();

    });

  }

  _getActiveRequest() async {

    FirebaseUser firebaseUser = await UserOfFirebase.getCurrentUser();

    Firestore db = Firestore.instance;
    DocumentSnapshot documentSnapshot = await db
        .collection("requisicao_ativa")
        .document(firebaseUser.uid)
        .get();

    if(documentSnapshot.data != null){

      Map<String, dynamic> data = documentSnapshot.data;
      _requestId = data["id_requisicao"];
      _addListenerOfRequest(_requestId);

    }else{
      _statusNotCalled();
    }

  }

  _addListenerOfRequest(String requestId) async {

    Firestore db = Firestore.instance;
    _streamSubscriptionRequests = await db.collection("requisicoes")
        .document(requestId).snapshots().listen((snapshot){

      if(snapshot.data != null){

        Map<String, dynamic> data = snapshot.data;
        _requestData = data;
        String status = data["status"];
        _requestId = data["id_requisicao"];

        switch(status){

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

  @override
  void initState() {
    super.initState();
    _getActiveRequest();
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
            itemBuilder: (context) {
              return menuItems.map((String item) {
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
              myLocationButtonEnabled: false,
              markers: _markers,
            ),
            Visibility(
              visible: _showDestinationBox,
              child: Stack(
                children: <Widget>[
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
                            color: Colors.white),
                        child: TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                              icon: Container(
                                margin: EdgeInsets.only(left: 20),
                                width: 10,
                                height: 10,
                                child: Icon(
                                  Icons.location_on,
                                  color: Colors.green,
                                ),
                              ),
                              hintText: "Meu local",
                              border: InputBorder.none,
                              contentPadding:
                              EdgeInsets.only(left: 15, top: 16)),
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
                            color: Colors.white),
                        child: TextField(
                          controller: _controllerDestination,
                          decoration: InputDecoration(
                              icon: Container(
                                margin: EdgeInsets.only(left: 20),
                                width: 10,
                                height: 10,
                                child: Icon(
                                  Icons.local_taxi,
                                  color: Colors.black,
                                ),
                              ),
                              hintText: "Digite o destino",
                              border: InputBorder.none,
                              contentPadding:
                              EdgeInsets.only(left: 15, top: 16)),
                        ),
                      ),
                    ),
                  )
                ],
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

  @override
  void dispose() {
    super.dispose();
    _streamSubscriptionRequests.cancel();
  }

}