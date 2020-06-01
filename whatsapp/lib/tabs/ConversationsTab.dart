/*
  Sabrina Karen
*/

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/data/ConversationData.dart';
import 'package:whatsapp/data/UserData.dart';

class ConversationsTab extends StatefulWidget {
  @override
  _ConversationsTabState createState() => _ConversationsTabState();
}

class _ConversationsTabState extends State<ConversationsTab> {
  List<ConversationData> _conversationList = List();
  final _controller = StreamController<QuerySnapshot>.broadcast();
  Firestore db = Firestore.instance;
  String _userId;

  @override
  void initState() {

    super.initState();

    _getUserData();

    ConversationData newConversation = ConversationData();
    newConversation.name = "Rodrigo";
    newConversation.message = "Branqueluxa";
    newConversation.photoPath =
        "https://firebasestorage.googleapis.com/v0/b/whatsapp-c376e.appspot.com/o/perfil%2Frod.png?alt=media&token=ba153718-09af-4d61-8e3e-d199d263c4ab";

    _conversationList.add(newConversation);

  }

  Stream<QuerySnapshot> _addListenerConversations() {

    final stream = db
        .collection("conversas")
        .document(_userId)
        .collection("ultima_conversa")
        .snapshots();

    stream.listen((dados) {
      _controller.add(dados);
    });

  }

  _getUserData() async {

    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser user = await auth.currentUser();

    _userId = user.uid;

    _addListenerConversations();

  }

  @override
  void dispose() {
    super.dispose();
    _controller.close();
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
      stream: _controller.stream,
      // ignore: missing_return
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: Column(
                children: <Widget>[
                  Text("Carregando conversas"),
                  CircularProgressIndicator()
                ],
              ),
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Text("Erro ao carregar os dados!");
            } else {
              QuerySnapshot querySnapshot = snapshot.data;

              if (querySnapshot.documents.length == 0) {
                return Center(
                  child: Text(
                    "Você não tem nenhuma mensagem ainda :( ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                );
              }

              return ListView.builder(
                  itemCount: _conversationList.length,
                  itemBuilder: (context, index) {
                    List<DocumentSnapshot> conversas = querySnapshot.documents.toList();
                    DocumentSnapshot item = conversas[index];

                    String urlImagem = item["caminhoFoto"];
                    String tipo = item["tipoMensagem"];
                    String mensagem = item["mensagem"];
                    String nome = item["nome"];
                    String idDestinatario       = item["idDestinatario"];

                    UserData user = UserData();
                    user.name = nome;
                    user.imageUrl = urlImagem;
                    user.idUsuario = idDestinatario;

                    return ListTile(
                      onTap: (){
                        Navigator.pushNamed(context, "/msg", arguments: user);
                      },
                      contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                      leading: CircleAvatar(
                        maxRadius: 30,
                        backgroundColor: Colors.grey,
                        backgroundImage:
                            urlImagem != null ? NetworkImage(urlImagem) : null,
                      ),
                      title: Text(
                        nome,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      subtitle: Text(tipo == "texto" ? mensagem : "Imagem...",
                          style: TextStyle(color: Colors.grey, fontSize: 14)),
                    );
                  });
            }
        }
      },
    );

  }

}