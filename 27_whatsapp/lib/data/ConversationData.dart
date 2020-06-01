/*
  Sabrina Karen
*/

import 'package:cloud_firestore/cloud_firestore.dart';

class ConversationData{

  String _senderId;
  String _receiverId;
  String _name;
  String _message;
  String _photoPath;
  String _messageType; // texto ou imagem

  ConversationData();

  save() async {

    Firestore db = Firestore.instance;
    await db.collection("conversas")
        .document(this.senderId)
        .collection("ultima_conversa")
        .document(this.receiverId)
        .setData(this.toMap());

  }

  Map<String, dynamic> toMap(){

    Map<String, dynamic> map = {
      "idRemetente": this.senderId,
      "idDestinatario": this.receiverId,
      "nome": this.name,
      "mensagem": this.message,
      "caminhoFoto": this.photoPath,
      "tipoMensagem": this.messageType,
    };

    return map;

  }

  String get messageType => _messageType;

  set messageType(String value) {
    _messageType = value;
  }

  String get photoPath => _photoPath;

  set photoPath(String value) {
    _photoPath = value;
  }

  String get message => _message;

  set message(String value) {
    _message = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get receiverId => _receiverId;

  set receiverId(String value) {
    _receiverId = value;
  }

  String get senderId => _senderId;

  set senderId(String value) {
    _senderId = value;
  }

}