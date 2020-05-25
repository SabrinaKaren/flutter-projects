/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:whatsapp/data/UserData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ContactsTab extends StatefulWidget {
  @override
  _ContactsTabState createState() => _ContactsTabState();
}

class _ContactsTabState extends State<ContactsTab> {

  String _userId;
  String _userEmail;

  Future<List<UserData>> _getContacts() async {
    List<UserData> listToReturn = List();

    Firestore db = Firestore.instance;
    QuerySnapshot query = await db.collection("usuarios").getDocuments();

    for (DocumentSnapshot item in query.documents) {
      if (item.data["email"] != _userEmail){

        UserData user = UserData();
        user.idUsuario = item.documentID;
        user.name = item.data["nome"];
        user.email = item.data["email"];
        user.imageUrl = item.data["urlImagem"];

        listToReturn.add(user);

      }
    }

    return listToReturn;
  }

  _getUserData() async {

    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser user = await auth.currentUser();
    _userId = user.uid;
    _userEmail = user.email;

  }

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<UserData>>(
      future: _getContacts(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Center(
              child: Column(
                children: <Widget>[
                  Text("Carregando contatos"),
                  CircularProgressIndicator(),
                ],
              ),
            );
            break;
          case ConnectionState.waiting:
            return Container();
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {

                UserData item = snapshot.data[index];

                return ListTile(
                  onTap: (){
                    Navigator.pushNamed(context, "/msg", arguments: item);
                  },
                  contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                  leading: CircleAvatar(
                    maxRadius: 30,
                    backgroundColor: Colors.grey,
                    backgroundImage: item.imageUrl != null ? NetworkImage(item.imageUrl) : null
                  ),
                  title: Text(
                    item.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                );

              },
            );
            break;
        }
      },
    );

  }

}