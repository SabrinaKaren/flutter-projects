/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  Firestore db = Firestore.instance;

  QuerySnapshot querySnapshot = await db.collection("usuarios")
      .where("nome", isGreaterThanOrEqualTo: "sa")
      .where("nome", isLessThanOrEqualTo: "sa" + "\uf8ff" )
      //.where("idade", isGreaterThan: 10)
      //.orderBy("idade", descending: false)
      .limit(4)
      .getDocuments();

  for( DocumentSnapshot item in querySnapshot.documents ){
    print("dados usuarios: " + item.data["nome"] + " - " + item.data["idade"].toString() );
  }

  runApp( App() );

}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}