/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  File _imageToShow;

  Future _recoverImage(bool fromCamera) async {

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
            RaisedButton(
              child: Text("Câmera"),
              onPressed: (){
                _recoverImage(true);
              },
            ),
            RaisedButton(
              child: Text("Galeria"),
              onPressed: (){
                _recoverImage(false);
              },
            ),
            _imageToShow == null ? Container() : Image.file(_imageToShow),
          ],
        ),
      ),
      backgroundColor: Colors.grey,
    );

  }

}