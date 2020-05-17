/*
  Sabrina Karen
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/data/UserData.dart';

class MessagesPage extends StatefulWidget {

  UserData contact;

  MessagesPage(this.contact);

  @override
  _MessagesPageState createState() => _MessagesPageState();

}

class _MessagesPageState extends State<MessagesPage> {

  TextEditingController _controllerMsg = TextEditingController();
  List<String> _msgsList = [
    "Olá meu amigo, tudo bem?",
    "Tudo ótimo!!! e contigo?",
    "Estou muito bem!! queria ver uma coisa contigo, você vai na corrida de sábado?",
    "Não sei ainda :(",
    "Pq se você fosse, queria ver se posso ir com você...",
    "Posso te confirma no sábado? vou ver isso",
    "Opa! tranquilo",
    "Excelente!!",
    "Estou animado para essa corrida, não vejo a hora de chegar! ;) ",
    "Vai estar bem legal!! muita gente",
    "vai sim!",
    "Lembra do carro que tinha te falado",
    "Que legal!!"
  ];

  _sendMessage(){

  }

  _sendPhoto(){

  }

  @override
  Widget build(BuildContext context) {
    
    var messageBox = Container(
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 8),
              child: TextField(
                controller: _controllerMsg,
                autofocus: true,
                keyboardType: TextInputType.text,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(32, 8, 32, 8),
                    hintText: "Digite uma mensagem...",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  prefixIcon: IconButton(
                    icon: Icon(Icons.camera_alt),
                    onPressed: _sendPhoto
                  ),
                ),
              ),
            ),
          ),
          FloatingActionButton(
            backgroundColor: Color(0xff075E54),
            child: Icon(Icons.send, color: Colors.white,),
            mini: true,
            onPressed: _sendMessage
          ),
        ],
      ),
    );

    var listView = Expanded(
      child: ListView.builder(
        itemCount: _msgsList.length,
        itemBuilder: (context, index){

          double containerWidth = MediaQuery.of(context).size.width * 0.8;

          Alignment alignment = Alignment.centerRight;
          Color boxColor = Color(0xffd2ffa5);
          if(index % 2 == 0){ //par
            alignment = Alignment.centerLeft;
            boxColor = Colors.white;
          }

          return Align(
            alignment: alignment,
            child: Padding(
              padding: EdgeInsets.all(6),
              child: Container(
                width: containerWidth,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: boxColor,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Text(
                    _msgsList[index],
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          );

        },
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contact.name),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                listView,
                messageBox,
              ],
            ),
          )
        ),
      ),
    );

  }

}