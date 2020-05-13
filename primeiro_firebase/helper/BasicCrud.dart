/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  Firestore db = Firestore.instance;

  // inserindo
  /*db.collection("usuarios").document("002").setData(
      {
        "nome" : "Alberto",
        "idade" : "19"
      }
  );*/

  // inserindo com código automático
  /*DocumentReference docRef = await db.collection("noticias").add(
      {
        "titulo" : "Covid-19",
        "descricao" : "Descrição desta notícia..."
      }
  );*/

  // deletando
  /*db.collection("usuarios")
      .document("002")
      .delete();*/

  // recuperando através de um documento
  /*DocumentSnapshot snapshot = await db
      .collection("usuarios")
      .document("001")
      .get();*/

  // recuperando todos os documentos
  /*QuerySnapshot snapshot = await db
      .collection("usuarios")
      .getDocuments();*/

  // recuperando todos os documentos de forma dinâmica (dados sendo atualizados em tempo real)
  /*db.collection("usuarios")
      .snapshots()
      .listen(
          (snapshot){
            for( DocumentSnapshot item in snapshot.documents ){
              print("dados usuarios: " + item.data["nome"] + " - " + item.data["idade"].toString() );
            }
          }
      );*/

  runApp( App() );

}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}