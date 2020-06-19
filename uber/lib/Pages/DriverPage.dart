/*
  Sabrina Karen
*/

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uber/Utils/RequestStatus.dart';

class DriverPage extends StatefulWidget {
  @override
  _DriverPageState createState() => _DriverPageState();
}

class _DriverPageState extends State<DriverPage> {

  List<String> menuItems = [
    "Configurações", "Deslogar"
  ];
  final _controller = StreamController<QuerySnapshot>.broadcast();
  Firestore db = Firestore.instance;

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

  Stream<QuerySnapshot> _addRequestsListener(){

    final stream = db.collection("requisicoes")
        .where("status", isEqualTo: RequestStatus.AGUARDANDO )
        .snapshots();

    stream.listen((data){
      _controller.add(data);
    });

  }

  @override
  void initState() {
    super.initState();
    _addRequestsListener();
  }

  @override
  Widget build(BuildContext context) {

    var loadingMessage = Center(
      child: Column(
        children: <Widget>[
          Text("Carregando requisições"),
          CircularProgressIndicator()
        ],
      ),
    );

    var noHasDataMessage = Center(
      child: Text(
        "Você não tem nenhuma requisição :( ",
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Painel motorista"),
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
      body: StreamBuilder<QuerySnapshot>(
          stream: _controller.stream,
          // ignore: missing_return
          builder: (context, snapshot){
            switch( snapshot.connectionState ){
              case ConnectionState.none:
              case ConnectionState.waiting:
                return loadingMessage;
                break;
              case ConnectionState.active:
              case ConnectionState.done:

                if( snapshot.hasError ){
                  return Text("Erro ao carregar os dados!");
                }else {

                  QuerySnapshot querySnapshot = snapshot.data;
                  if( querySnapshot.documents.length == 0 ){
                    return noHasDataMessage;
                  }else{

                    return ListView.separated(
                        itemCount: querySnapshot.documents.length,
                        separatorBuilder: (context, index) => Divider(
                          height: 2,
                          color: Colors.grey,
                        ),
                        itemBuilder: (context, index){

                          List<DocumentSnapshot> requests = querySnapshot.documents.toList();
                          DocumentSnapshot item = requests[index];

                          String requestId = item["id"];
                          String passengerName = item["passageiro"]["nome"];
                          String street = item["destino"]["rua"];
                          String number = item["destino"]["numero"];

                          return ListTile(
                            title: Text(passengerName),
                            subtitle: Text("destino: $street, $number"),
                            onTap: (){
                              Navigator.pushNamed(
                                  context,
                                  "/corrida",
                                  arguments: requestId
                              );
                            },
                          );

                        }
                    );

                  }

                }

                break;
            }
          }
      ),
    );

  }

}