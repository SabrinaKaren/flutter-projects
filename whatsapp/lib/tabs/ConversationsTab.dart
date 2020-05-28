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

  List<ConversationData> _conversationList = List();

  @override
  void initState() {

    super.initState();

    ConversationData newConversation = ConversationData();
    newConversation.name = "Rodrigo";
    newConversation.message = "Branqueluxa";
    newConversation.photoPath = "https://firebasestorage.googleapis.com/v0/b/whatsapp-c376e.appspot.com/o/perfil%2Frod.png?alt=media&token=ba153718-09af-4d61-8e3e-d199d263c4ab";

    _conversationList.add(newConversation);

  }

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