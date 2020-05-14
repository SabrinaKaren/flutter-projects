/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:whatsapp/data/ConversationData.dart';

class ConversationsTab extends StatefulWidget {
  @override
  _ConversationsTabState createState() => _ConversationsTabState();
}

class _ConversationsTabState extends State<ConversationsTab> {

  List<ConversationData> _conversationList = [
    ConversationData(
      "Rodrigo",
      "Branqueluxa",
      "https://firebasestorage.googleapis.com/v0/b/whatsapp-c376e.appspot.com/o/perfil%2Frod.png?alt=media&token=ba153718-09af-4d61-8e3e-d199d263c4ab"
    ),
    ConversationData(
        "Desenvolvimento CERCRED",
        "Atualiza o homologação pfv",
        "https://firebasestorage.googleapis.com/v0/b/whatsapp-c376e.appspot.com/o/perfil%2Fcercred.png?alt=media&token=fa19c591-7dd2-4781-a09d-5b8acbd18f70"
    ),
    ConversationData(
        "Vet Vale",
        "Como está o rapaizinho?",
        "https://firebasestorage.googleapis.com/v0/b/whatsapp-c376e.appspot.com/o/perfil%2FvetVale.png?alt=media&token=bcdb8488-030d-457c-9fe1-88984ac2366a"
    ),
    ConversationData(
        "Tri cats",
        "Estamos levando pão de queijo",
        "https://firebasestorage.googleapis.com/v0/b/whatsapp-c376e.appspot.com/o/perfil%2FtriCats.png?alt=media&token=ee3d0644-783f-47a3-9ea3-3cc03422e3e8"
    ),
    ConversationData(
        "Joyce",
        "Aeeeeee JoJo voltou para casa",
        "https://firebasestorage.googleapis.com/v0/b/whatsapp-c376e.appspot.com/o/perfil%2Fjoyce.png?alt=media&token=f248c977-08e8-4948-b773-faa89708751b"
    )
  ];

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: _conversationList.length,
      itemBuilder: (context, index){

        ConversationData item = _conversationList[index];

        return ListTile(

          contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),

          // foto
          leading: CircleAvatar(
            maxRadius: 30,
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(item.photoPath),
          ),

          // nome da pessoa
          title: Text(
            item.name,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16
            ),
          ),

          // mensagem
          subtitle: Text(
              item.message,
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14
              )
          ),

        );

      },
    );

  }

}