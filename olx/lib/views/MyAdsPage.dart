/*
  Sabrina Karen
*/

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:olx/data/AdData.dart';
import 'package:olx/views/widgets/AdItem.dart';

class MyAdsPage extends StatefulWidget {
  @override
  _MyAdsPageState createState() => _MyAdsPageState();
}

class _MyAdsPageState extends State<MyAdsPage> {

  final _controller = StreamController<QuerySnapshot>.broadcast();
  String _loggedUserId;

  _getLoggedUserData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser loggedUser = await auth.currentUser();
    _loggedUserId = loggedUser.uid;
  }

  Future<Stream<QuerySnapshot>> _addListenerAds() async {

    await _getLoggedUserData();

    Firestore db = Firestore.instance;
    Stream<QuerySnapshot> stream = db
        .collection("meus_anuncios")
        .document(_loggedUserId)
        .collection("anuncios")
        .snapshots();

    stream.listen((data) {
      _controller.add(data);
    });

  }

  _deleteAd(String adId) {

    Firestore db = Firestore.instance;
    db
        .collection("meus_anuncios")
        .document(_loggedUserId)
        .collection("anuncios")
        .document(adId)
        .delete()
        .then((_) {
      db.collection("anuncios")
          .document(adId).delete();
    });

  }

  @override
  void initState() {
    super.initState();
    _addListenerAds();
  }

  @override
  Widget build(BuildContext context) {

    var loadingData = Center(
      child: Column(
        children: <Widget>[
          Text("Carregando anúncios"),
          CircularProgressIndicator()
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Meus Anúncios"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        foregroundColor: Colors.white,
        icon: Icon(Icons.add),
        label: Text("Adicionar"),
        //child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, "/novo-anuncio");
        },
      ),
      body: StreamBuilder(
        stream: _controller.stream,
        builder: (context, snapshot) {

          switch (snapshot.connectionState) {

            case ConnectionState.none:
            case ConnectionState.waiting:
              return loadingData;
              break;
            case ConnectionState.active:
            case ConnectionState.done:

              if (snapshot.hasError) return Text("Erro ao carregar os dados!");

              QuerySnapshot querySnapshot = snapshot.data;

              return ListView.builder(
                  itemCount: querySnapshot.documents.length,
                  itemBuilder: (_, index) {

                    List<DocumentSnapshot> ads = querySnapshot.documents.toList();
                    DocumentSnapshot documentSnapshot = ads[index];
                    AdData ad = AdData.fromDocumentSnapshot(documentSnapshot);

                    return AdItem(
                      ad: ad,
                      onPressedRemover: () {
                        showDialog(
                            context: context,
                            builder: (context) {

                              return AlertDialog(
                                title: Text("Confirmar"),
                                content: Text("Deseja realmente excluir o anúncio?"),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text(
                                      "Cancelar",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  FlatButton(
                                    color: Colors.red,
                                    child: Text(
                                      "Remover",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      _deleteAd(ad.id);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );

                            }
                        );
                      },
                    );
                  }
              );
          }

          return Container();

        },
      ),
    );

  }

}