/*
  Sabrina Karen
 */
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minhasviagens/MapPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List _placesList = [
    "Cristo Redentor",
    "Grande Muralha da China",
    "Taj Mahal",
    "Machu Picchu",
    "Coliseu"
  ];

  _openMap(){

  }

  _deletePlace(){

  }

  _addPlace(){

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => MapPage(),
        )
    );

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
        stream: null,
        // ignore: missing_return
        builder: (context, snapshot){

          switch(snapshot.connectionState){

            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
            case ConnectionState.done:

              return Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: _placesList.length,
                      itemBuilder: (context, index){

                        String title = _placesList[index];

                        return GestureDetector(
                          onTap: (){
                            _openMap();
                          },
                          child: Card(
                            child: ListTile(
                              title: Text(title),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: (){
                                      _deletePlace();
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