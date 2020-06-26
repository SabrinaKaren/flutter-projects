/*
  Sabrina Karen
  Desc.: usando animações para fazer um avião "voar"
*/

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool _status = true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedContainer(
        duration: Duration(seconds: 1),
        color: Colors.lightBlueAccent,
        padding: EdgeInsets.only(bottom: 100, top: 20),
        alignment: _status ? Alignment.bottomCenter : Alignment.topCenter,
        child: AnimatedOpacity(
          duration: Duration(seconds: 1),
          opacity: _status ? 1 : 0 ,
          child: Container(
            height: 50,
            child: Icon(
              Icons.airplanemode_active,
              size: 50,
              color: Colors.white,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        elevation: 30,
        child: Icon(Icons.play_arrow),
        onPressed: (){
          setState(() {
            _status = !_status;
          });
        },
      ),
    );

  }

}