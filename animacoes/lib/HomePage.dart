/*
  Sabrina Karen
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
      appBar: AppBar(
        title: Text(
          "Animações",
          style: TextStyle(
              color: Colors.blue
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: GestureDetector(
          onTap: (){
            setState(() {
              _status = !_status;
            });
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.linear,
            alignment: Alignment.center,
            width: _status ? 60 : 160 ,
            height: 60,
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30)
            ),
            child: Stack(children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 100),
                  opacity: _status ? 1 : 0 ,
                  child: Icon(Icons.person_add, color: Colors.white,),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 100),
                  opacity: _status ? 0 : 1 ,
                  child: Text(
                    "Mensagem",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                    ),
                  ),
                ),
              )
            ],),
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