/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  File _imageToShow;
  String _statusUpload = "Upload não iniciado";
  String _imageUrl = null;

  Future _choiceImage(bool fromCamera) async {

    File selectedImage;

    if (fromCamera){
      selectedImage = await ImagePicker.pickImage(source: ImageSource.camera);
    } else {
      selectedImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    }

    setState(() {
      _imageToShow = selectedImage;
    });

  }

  Future _imageUpload() async {

    FirebaseStorage storage = FirebaseStorage.instance;

    // Referenciando o arquivo
    StorageReference pastaRaiz = storage.ref();
    StorageReference arquivo = pastaRaiz
        .child("fotos")
        .child("foto1.jpg");

    // Fazendo upload da imagem
    StorageUploadTask task = arquivo.putFile(_imageToShow);

    // Controlando progresso do upload
    task.events.listen((StorageTaskEvent storageEvent){

      if(storageEvent.type == StorageTaskEventType.progress){
        setState(() {
          _statusUpload = "Em progresso";
        });
      }else if(storageEvent.type == StorageTaskEventType.success){
        setState(() {
          _statusUpload = "Upload realizado com sucesso!";
        });
      }

    });

    // Recuperando a url da imagem
    task.onComplete.then((StorageTaskSnapshot snapshot){
      _getImageUrl( snapshot );
    });

  }

  Future _getImageUrl(StorageTaskSnapshot snapshot) async {

    String url = await snapshot.ref.getDownloadURL();
    print("Resultado url: " + url );

    setState(() {
      _imageUrl = url;
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Selecionador de imagem"),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Text(_statusUpload),
            RaisedButton(
              child: Text("Camera"),
              onPressed: (){
                _choiceImage(true);
              },
            ),
            RaisedButton(
              child: Text("Galeria"),
              onPressed: (){
                _choiceImage(false);
              },
            ),
            _imageToShow == null
                ? Container()
                : Image.file(_imageToShow),
            _imageToShow == null
                ? Container()
                : RaisedButton(
              child: Text("Upload Storage"),
              onPressed: (){
                _imageUpload();
              },
            ),
            _imageUrl == null
                ? Container()
                : Image.network(_imageUrl)
          ],
        ),
      ),
      backgroundColor: Colors.grey,
    );

  }

}