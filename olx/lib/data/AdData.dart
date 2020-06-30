/*
  Sabrina Karen
*/

import 'package:cloud_firestore/cloud_firestore.dart';

class AdData{

  String _id;
  String _state;
  String _category;
  String _title;
  String _price;
  String _phone;
  String _description;
  List<String> _photos;

  AdData();

  AdData.fromDocumentSnapshot(DocumentSnapshot documentSnapshot){

    this.id = documentSnapshot.documentID;
    this.state = documentSnapshot["estado"];
    this.category = documentSnapshot["categoria"];
    this.title = documentSnapshot["titulo"];
    this.price = documentSnapshot["preco"];
    this.phone = documentSnapshot["telefone"];
    this.description = documentSnapshot["descricao"];
    this.photos = List<String>.from(documentSnapshot["fotos"]);

  }

  AdData.generateId(){

    Firestore db = Firestore.instance;
    CollectionReference ads = db.collection("meus_anuncios");
    this.id = ads.document().documentID;

    this.photos = [];

  }

  Map<String, dynamic> toMap(){

    Map<String, dynamic> map = {
      "id" : this.id,
      "estado" : this.state,
      "categoria" : this.category,
      "titulo" : this.title,
      "preco" : this.price,
      "telefone" : this.phone,
      "descricao" : this.description,
      "fotos" : this.photos,
    };

    return map;

  }

  List<String> get photos => _photos;

  set photos(List<String> value) {
    _photos = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get phone => _phone;

  set phone(String value) {
    _phone = value;
  }

  String get price => _price;

  set price(String value) {
    _price = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  String get category => _category;

  set category(String value) {
    _category = value;
  }

  String get state => _state;

  set state(String value) {
    _state = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

}