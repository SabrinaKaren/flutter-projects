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

  _onMapCreated(GoogleMapController googleMapController){
    _controller.complete(googleMapController);
  }

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

  _moveCamera() async {

    GoogleMapController googleMapController = await _controller.future;
    googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
            _cameraPosition
        )
    );

  }

  _getLocationToAddress() async {

    List<Placemark> addressList = await Geolocator()
        .placemarkFromAddress("Av. Paulista, 1372");

    if(addressList != null && addressList.length > 0){

      Placemark address = addressList[0];
      String result;

      result  = "\n administrativeArea " + address.administrativeArea ;
      result += "\n subAdministrativeArea " + address.subAdministrativeArea ;
      result += "\n locality " + address.locality ;
      result += "\n subLocality " + address.subLocality ;
      result += "\n thoroughfare " + address.thoroughfare ;
      result += "\n subThoroughfare " + address.subThoroughfare ;
      result += "\n postalCode " + address.postalCode ;
      result += "\n country " + address.country ;
      result += "\n isoCountryCode " + address.isoCountryCode ;
      result += "\n position " + address.position.toString() ;

      print("resultado: " + result);

    }

  }

  _getLocationToLatLong() async {

    List<Placemark> addressList = await Geolocator()
        .placemarkFromCoordinates(-23.565564, -46.652753);

    if(addressList != null && addressList.length > 0){

      Placemark address = addressList[0];
      String result;

      result  = "\n administrativeArea " + address.administrativeArea ;
      result += "\n subAdministrativeArea " + address.subAdministrativeArea ;
      result += "\n locality " + address.locality ;
      result += "\n subLocality " + address.subLocality ;
      result += "\n thoroughfare " + address.thoroughfare ;
      result += "\n subThoroughfare " + address.subThoroughfare ;
      result += "\n postalCode " + address.postalCode ;
      result += "\n country " + address.country ;
      result += "\n isoCountryCode " + address.isoCountryCode ;
      result += "\n position " + address.position.toString() ;

      print("resultado: " + result);

    }

  }

  @override
  void initState() {
    super.initState();
    //_getCurrentLocation();
    //_monitoringUserLocation();
    //_getLocationToAddress();
    _getLocationToLatLong();
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