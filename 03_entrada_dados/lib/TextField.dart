/*
  Author: Sabrina Karen
*/

import 'package:flutter/material.dart';

class TextField extends StatefulWidget {
  @override
  _TextFieldState createState() => _TextFieldState();
}

class _TextFieldState extends State<TextField> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Entrada de dados"
        ),
        backgroundColor: Colors.grey
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
  }

}
