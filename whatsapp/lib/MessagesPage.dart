/*
  Sabrina Karen
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/data/MessageData.dart';
import 'package:whatsapp/data/UserData.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class MessagesPage extends StatefulWidget {
  UserData contact;
  MessagesPage(this.contact);

  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {

  TextEditingController _controllerMsg = TextEditingController();
  String _userId;
  String _userReceiverId;
  Firestore db = Firestore.instance;
  File selectedImage;
  bool _uploadingImage = false;

  _getUserData() async {

    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser user = await auth.currentUser();
    _userId = user.uid;
    _userReceiverId = widget.contact.idUsuario;

  }

  _sendMessage(){

    String messageText = _controllerMsg.text;
    if(messageText.isNotEmpty){

      MessageData messageObject = MessageData();
      messageObject.idUsuario = _userId;
      messageObject.mensagem  = messageText;
      messageObject.urlImagem = "";
      messageObject.tipo = "texto";

      // salvando msg para o remetente
      _saveMessage(_userId, _userReceiverId, messageObject);

      // salvando msg para o destinatário
      _saveMessage(_userReceiverId, _userId, messageObject);

    }

  }

  _saveMessage(String senderId, String receiverId, MessageData msg) async {

    await db.collection("mensagens")
        .document(senderId)
        .collection(receiverId)
        .add(msg.toMap());

    _controllerMsg.clear();

  }

  _sendPhoto() async {

    File selectedImage;
    selectedImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    _uploadingImage = true;

    String imageName = DateTime.now().millisecondsSinceEpoch.toString();

    FirebaseStorage storage = FirebaseStorage.instance;

    StorageReference rootFolder = storage.ref();
    StorageReference archive = rootFolder
        .child("mensagens")
        .child(_userId)
        .child(imageName + ".jpg");

    // uploading da imagem
    StorageUploadTask task = archive.putFile(selectedImage);

    // controlando progresso do upload
    task.events.listen((StorageTaskEvent storageEvent){
      if (storageEvent.type == StorageTaskEventType.progress){
        setState(() {
          _uploadingImage = true;
        });
      } else if (storageEvent.type == StorageTaskEventType.success){
        setState(() {
          _uploadingImage = false;
        });
      }
    });

    // recuperando url da imagem
    task.onComplete.then((StorageTaskSnapshot snapshot){
      _getImageUrl(snapshot);
    });

  }

  Future _getImageUrl(StorageTaskSnapshot snapshot) async {

    String url = await snapshot.ref.getDownloadURL();

    MessageData messageObject = MessageData();
    messageObject.idUsuario = _userId;
    messageObject.mensagem  = "";
    messageObject.urlImagem = url;
    messageObject.tipo = "imagem";

    // salvando msg para o remetente
    _saveMessage(_userId, _userReceiverId, messageObject);

    // salvando msg para o destinatário
    _saveMessage(_userReceiverId, _userId, messageObject);

  }

  @override
  void initState() {
    super.initState();
    _getUserData();
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
                  prefixIcon:
                    _uploadingImage
                        ? CircularProgressIndicator()
                        : IconButton(icon: Icon(Icons.camera_alt), onPressed: _sendPhoto)
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

    var stream = StreamBuilder(
      stream: db
          .collection("mensagens")
          .document(_userId)
          .collection(_userReceiverId)
          .snapshots(),
      // ignore: missing_return
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: Column(
                children: <Widget>[
                  Text("Carregando mensagens"),
                  CircularProgressIndicator()
                ],
              ),
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:

            QuerySnapshot querySnapshot = snapshot.data;

            if (snapshot.hasError) {
              return Expanded(
                child: Text("Erro ao carregar os dados!"),
              );
            } else {
              return Expanded(
                child: ListView.builder(
                    itemCount: querySnapshot.documents.length,
                    itemBuilder: (context, indice) {

                      List<DocumentSnapshot> mensagens = querySnapshot.documents.toList();
                      DocumentSnapshot item = mensagens[indice];

                      double larguraContainer = MediaQuery.of(context).size.width * 0.8;

                      Alignment alinhamento = Alignment.centerRight;
                      Color cor = Color(0xffd2ffa5);
                      if (_userId != item["idUsuario"]) {
                        alinhamento = Alignment.centerLeft;
                        cor = Colors.white;
                      }

                      return Align(
                        alignment: alinhamento,
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: Container(
                            width: larguraContainer,
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: cor,
                                borderRadius:
                                BorderRadius.all(Radius.circular(8))),
                            child:
                            item["tipo"] == "texto"
                              ? Text(item["mensagem"], style: TextStyle(fontSize: 18))
                              : Image.network(item["urlImagem"]),
                          ),
                        ),
                      );
                    }),
              );
            }

            break;
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            CircleAvatar(
                maxRadius: 20,
                backgroundColor: Colors.grey,
                backgroundImage: widget.contact.imageUrl != null ? NetworkImage(widget.contact.imageUrl) : null
            ),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(widget.contact.name),
            )
          ],
        ),
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
                  stream,
                  messageBox,
                ],
              ),
            )
        ),
      ),
    );

  }

}