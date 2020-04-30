/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';

class SecondaryScreen extends StatefulWidget {
  @override
  _SecondaryScreenState createState() => _SecondaryScreenState();
}

class _SecondaryScreenState extends State<SecondaryScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Tela secundária"),
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: <Widget>[
            Text("Você está na segunda tela!", style: TextStyle(fontSize: 20, color: Colors.black),),
          ],
        ),
      ),
    );

  }

}
