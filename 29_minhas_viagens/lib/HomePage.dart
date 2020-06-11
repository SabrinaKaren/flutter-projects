/*
  Sabrina Karen
 */
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minhasviagens/MapPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _controller = StreamController<QuerySnapshot>.broadcast();
  Firestore _db = Firestore.instance;

  _openMap(String tripId){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => MapPage(tripId: tripId,)
        )
    );
  }

  _deletePlace(String tripId){
    _db.collection("viagens")
        .document(tripId)
        .delete();
  }

  _addPlace(){

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => MapPage(),
        )
    );

  }

  _addListener() async {

    final stream = _db.collection("viagens").snapshots();

    stream.listen((data){
      _controller.add(data);
    });

  }

  @override
  void initState() {
    super.initState();
    _addListener();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas viagens"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _addPlace();
        },
        child: Icon(
          Icons.add,
          color: Color(0xff0066cc),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _controller.stream,
        // ignore: missing_return
        builder: (context, snapshot){

          switch(snapshot.connectionState){

            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
            case ConnectionState.done:

              QuerySnapshot querySnapshot = snapshot.data;
              List<DocumentSnapshot> trips = querySnapshot.documents.toList();

              return Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: trips.length,
                      itemBuilder: (context, index){

                        DocumentSnapshot item = trips[index];
                        String tripId = item.documentID;

                        return GestureDetector(
                          onTap: (){
                            _openMap(tripId);
                          },
                          child: Card(
                            child: ListTile(
                              title: Text(item["titulo"]),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: (){
                                      _deletePlace(tripId);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Icon(
                                        Icons.remove_circle,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );

                      },
                    ),
                  )
                ],
              );

              break;

          }

        },
      ),
    );

  }

}