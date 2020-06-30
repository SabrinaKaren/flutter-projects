/*
  Sabrina Karen
*/

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:olx/data/AdData.dart';
import 'package:olx/main.dart';
import 'package:olx/utils/DropdownItems.dart';
import 'package:olx/views/widgets/AdItem.dart';

class AdsPage extends StatefulWidget {
  @override
  _AdsPageState createState() => _AdsPageState();
}

class _AdsPageState extends State<AdsPage> {

  List<String> menuItems = [];
  List<DropdownMenuItem<String>> _categoriesList;
  List<DropdownMenuItem<String>> _statesList;
  final _controler = StreamController<QuerySnapshot>.broadcast();
  String _stateSelected;
  String _categorySelected;

  _menuChoice(String choice) {

    switch (choice) {

      case "Meus anúncios":
        Navigator.pushNamed(context, "/meus-anuncios");
        break;
      case "Entrar/Cadastrar":
        Navigator.pushNamed(context, "/login");
        break;
      case "Deslogar":
        _logoutUser();
        break;

    }

  }

  _logoutUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushNamed(context, "/login");
  }

  Future _checkLoggedUser() async {

    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser loggedUser = await auth.currentUser();

    if (loggedUser == null) {
      menuItems = ["Entrar/Cadastrar"];
    } else {
      menuItems = ["Meus anúncios", "Deslogar"];
    }

  }

  _loadDropItems() {
    _categoriesList = DropdownItems.getCategories();
    _statesList = DropdownItems.getStates();
  }

  Future<Stream<QuerySnapshot>> _addAdsListener() async {

    Firestore db = Firestore.instance;
    Stream<QuerySnapshot> stream = db.collection("anuncios").snapshots();

    stream.listen((data) {
      _controler.add(data);
    });

  }

  Future<Stream<QuerySnapshot>> _filterAds() async {

    Firestore db = Firestore.instance;
    Query query = db.collection("anuncios");

    if (_stateSelected != null) {
      query = query.where("estado", isEqualTo: _stateSelected);
    }
    if (_categorySelected != null) {
      query = query.where("categoria", isEqualTo: _categorySelected);
    }

    Stream<QuerySnapshot> stream = query.snapshots();
    stream.listen((data) {
      _controler.add(data);
    });

  }

  @override
  void initState() {
    super.initState();
    _loadDropItems();
    _checkLoggedUser();
    _addAdsListener();
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
        title: Text("OLX"),
        elevation: 0,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _menuChoice,
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
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: Center(
                      child: DropdownButton(
                        iconEnabledColor: defaultTheme.primaryColor,
                        value: _stateSelected,
                        items: _statesList,
                        style: TextStyle(fontSize: 22, color: Colors.black),
                        onChanged: (state) {
                          setState(() {
                            _stateSelected = state;
                            _filterAds();
                          });
                        },
                      ),
                    )
                  ),
                ),
                Container(
                  color: Colors.grey[200],
                  width: 2,
                  height: 60,
                ),
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: Center(
                      child: DropdownButton(
                        iconEnabledColor: Color(0xff9c27b0),
                        value: _categorySelected,
                        items: _categoriesList,
                        style: TextStyle(fontSize: 22, color: Colors.black),
                        onChanged: (category) {
                          setState(() {
                            _categorySelected = category;
                            _filterAds();
                          });
                        },
                      ),
                    )
                  ),
                )
              ],
            ),
            StreamBuilder(
              stream: _controler.stream,
              builder: (context, snapshot) {

                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return loadingData;
                    break;
                  case ConnectionState.active:
                  case ConnectionState.done:
                    QuerySnapshot querySnapshot = snapshot.data;

                    if (querySnapshot.documents.length == 0) {
                      return Container(
                        padding: EdgeInsets.all(25),
                        child: Text(
                          "Nenhum anúncio! :( ",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      );
                    }

                    return Expanded(
                      child: ListView.builder(
                          itemCount: querySnapshot.documents.length,
                          itemBuilder: (_, index) {

                            List<DocumentSnapshot> ads = querySnapshot.documents.toList();
                            DocumentSnapshot documentSnapshot = ads[index];
                            AdData ad = AdData.fromDocumentSnapshot(documentSnapshot);

                            return AdItem(
                              ad: ad,
                              onTapItem: () {
                                Navigator.pushNamed(
                                    context, "/detalhes-anuncio",
                                    arguments: ad
                                );
                              },
                            );

                          }
                      ),
                    );
                }
                return Container();

              },
            )
          ],
        ),
      ),
    );

  }

}