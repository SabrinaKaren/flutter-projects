/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'SecondaryScreen.dart';

class PrimaryScreen extends StatefulWidget {
  @override
  _PrimaryScreenState createState() => _PrimaryScreenState();
}

class _PrimaryScreenState extends State<PrimaryScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Tela principal"),
        backgroundColor: Colors.green,
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("Ir para a segunda tela", style: TextStyle(fontSize: 20, color: Colors.white),),
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SecondaryScreen()
                    )
                );
              },
              color: Colors.green,
            )
          ],
        ),
      ),
    );

  }

}
