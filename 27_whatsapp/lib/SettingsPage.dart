/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsPage> {

  TextEditingController _controllerName = TextEditingController();
  File _image;
  String _userId;
  bool _uploadingImage = false;
  String _imageUrl;

  Future _getImage(String imageSource) async {

    File selectedImage;

    switch(imageSource){
      case "camera":
        selectedImage = await ImagePicker.pickImage(source: ImageSource.camera);
        break;
      case "galeria":
        selectedImage = await ImagePicker.pickImage(source: ImageSource.gallery);
        break;
    }

    setState(() {
      _image = selectedImage;
      if (_image != null){
        _uploadingImage = true;
        _imageUpload();
      }
    });

  }

  Future _imageUpload() async {

    FirebaseStorage storage = FirebaseStorage.instance;

    StorageReference rootFolder = storage.ref();
    StorageReference archive = rootFolder
        .child("perfil")
        .child(_userId + ".jpg");

    // uploading da imagem
    StorageUploadTask task = archive.putFile(_image);

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
    _updatImageURLFirestore(url);
    setState(() {
      _imageUrl = url;
    });

  }

  _updatImageURLFirestore(String url){

    Firestore db = Firestore.instance;

    Map<String, dynamic> dataUpload = {
      "urlImagem": url
    };
    
    db.collection("usuarios")
        .document(_userId)
        .updateData(dataUpload);

  }

  _updatUserNameFirestore(){

    String name = _controllerName.text;

    Firestore db = Firestore.instance;

    Map<String, dynamic> dataUpload = {
      "nome": name
    };

    db.collection("usuarios")
        .document(_userId)
        .updateData(dataUpload);

  }

  _getUserData() async {

    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser user = await auth.currentUser();
    _userId = user.uid;

    Firestore db = Firestore.instance;
    DocumentSnapshot snapshot = await db.collection("usuarios")
        .document(_userId)
        .get();

    Map<String, dynamic> data = snapshot.data;
    _controllerName.text = data["nome"];

    if (data ["urlImagem"] != null){
      setState(() {
        _imageUrl = data ["urlImagem"];
      });
    }

  }

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Configurações"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(16),
                  child: _uploadingImage ? CircularProgressIndicator() : Container(),
                ),
                CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.grey,
                  backgroundImage: _imageUrl != null ? NetworkImage(_imageUrl) : null,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      child: Text(
                        "Câmera"
                      ),
                      onPressed: (){
                        _getImage("camera");
                      },
                    ),
                    FlatButton(
                      child: Text(
                        "Galeria"
                      ),
                      onPressed: (){
                        _getImage("galeria");
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerName,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "Nome",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 10),
                  child: RaisedButton(
                    child: Text(
                      "Salvar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    color: Colors.green,
                    padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    onPressed: () {
                      _updatUserNameFirestore();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }

}