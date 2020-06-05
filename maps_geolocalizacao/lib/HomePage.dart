/*
  Sabrina Karen
 */

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  Set<Polygon> _polygons  = {};
  Set<Polyline> _polylines  = {};

  _onMapCreated(GoogleMapController googleMapController){
    _controller.complete(googleMapController);
  }

  _moveCamera() async {

    GoogleMapController googleMapController = await _controller.future;
    googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(-23.562436, -46.655005),
                zoom: 16,
                tilt: 0,
                bearing: 270
            )
        )
    );

  }

  _loadMarkers(){

    Set<Marker> localMarkers = {};

    Marker marcadorShopping = Marker(
        markerId: MarkerId("marcador-shopping"),
        position: LatLng(-23.563370, -46.652923),
        infoWindow: InfoWindow(
            title: "Shopping Cidade São Paulo"
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueMagenta
        ),
        onTap: (){
          print("Shopping clicado!!");
        }
      //rotation: 45
    );

    Marker marcadorCartorio = Marker(
        markerId: MarkerId("marcador-cartorio"),
        position: LatLng(-23.562868, -46.655874),
        infoWindow: InfoWindow(
            title: "12 Cartório de notas"
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueBlue
        ),
        onTap: (){
          print("Cartório clicado!!");
        }
    );

    localMarkers.add(marcadorShopping);
    localMarkers.add(marcadorCartorio);

    setState(() {
      _markers = localMarkers;
    });

  }

  _loadPolygons() async {

    Set<Polygon> polygonsList = {};

    Polygon polygon1 = Polygon(
        polygonId: PolygonId("polygon1"),
        fillColor: Colors.green,
        strokeColor: Colors.red,
        strokeWidth: 20,
        points: [
          LatLng(-23.561816, -46.652044),
          LatLng(-23.563625, -46.653642),
          LatLng(-23.564786, -46.652226),
          LatLng(-23.563085, -46.650531),
        ],
        consumeTapEvents: true,
        onTap: (){
          print("clicado na área");
        },
        zIndex: 1
    );

    Polygon polygon2 = Polygon(
        polygonId: PolygonId("polygon2"),
        fillColor: Colors.purple,
        strokeColor: Colors.orange,
        strokeWidth: 20,
        points: [
          LatLng(-23.561629, -46.653031),
          LatLng(-23.565189, -46.651872),
          LatLng(-23.562032, -46.650831),
        ],
        consumeTapEvents: true,
        onTap: (){
          print("clicado na área");
        },
        zIndex: 0
    );

    polygonsList.add(polygon1);
    polygonsList.add(polygon2);

    setState(() {
      _polygons = polygonsList;
    });

  }

  _loadPolylines() async {

    Set<Polyline> polylinesList = {};
    Polyline polyline = Polyline(
        polylineId: PolylineId("polyline"),
        color: Colors.red,
        width: 10,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        jointType: JointType.round,
        points: [
          LatLng(-23.563645, -46.653642),
          LatLng(-23.565160, -46.651797),
          LatLng(-23.563232, -46.648020),
        ],
        consumeTapEvents: true,
        onTap: (){
          print("clicado na área");
        }
    );

    polylinesList.add(polyline);
    setState(() {
      _polylines = polylinesList;
    });

  }

  @override
  void initState() {
    super.initState();
    //_loadMarkers();
    //_loadPolygons();
    _loadPolylines();
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
          initialCameraPosition: CameraPosition(
              target: LatLng(-23.562436, -46.655005),
              zoom: 16
          ),
          onMapCreated: _onMapCreated,
          markers: _markers,
          polygons: _polygons,
          polylines: _polylines,
        ),
      ),
    );

  }

}