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
import 'package:uber/Data/DestinationData.dart';
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
  TextEditingController _controllerDestination  = TextEditingController(text: "av. Bias Fortes, 162" );
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

      } else{

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

        String addressVerification;
        addressVerification = "\n Cidade: " + destination.city;
        addressVerification += "\n Rua: " + destination.street + ", " + destination.number;
        addressVerification += "\n Bairro: " + destination.neighborhood;
        addressVerification += "\n Cep: " + destination.cep;

        showDialog(
            context: context,
            builder: (contex) {
              return AlertDialog(
                title: Text("Confirmação do endereço"),
                content: Text(addressVerification),
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
                      _saveResquest(destination);
                      Navigator.pop(contex);
                    },
                  )
                ],
              );
            });

      }

    }

  }

  _saveResquest(DestinationData destination) async {

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

    _moveCamera( cameraPosition );

  }

  _statusOnTheWay() {

    _showDestinationBox = false;

    _changeMainButton(
        "Motorista a caminho",
        Colors.grey,
            () {

        });

    double passengerLat = _requestData["passageiro"]["latitude"];
    double passengerLon = _requestData["passageiro"]["longitude"];

    double driverLat = _requestData["motorista"]["latitude"];
    double driverLon = _requestData["motorista"]["longitude"];

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
      sLon = passengerLon;
      nLon = driverLon;
    }

    _moveCameraBounds(
        LatLngBounds(
            northeast: LatLng(nLat, nLon),
            southwest: LatLng(sLat, sLon)
        )
    );

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

  _cancelUber() async {

    FirebaseUser firebaseUser = await UserOfFirebase.getCurrentUser();

    Firestore db = Firestore.instance;
    db.collection("requisicoes")
        .document(_requestId).updateData({
      "status" : RequestStatus.CANCELADA
    }).then((_){

      db.collection("requisicao_ativa")
          .document( firebaseUser.uid )
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
            _statusWaiting();
            break;
          case RequestStatus.VIAGEM :

            break;
          case RequestStatus.FINALIZADA :

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
                          controller: _controllerDestination,
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
                    onPressed: _buttonFunction,
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