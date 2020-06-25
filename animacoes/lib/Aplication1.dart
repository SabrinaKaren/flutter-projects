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

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AnimatedContainer(
          padding: EdgeInsets.all(20),
          width: _status ? 200 : 300 ,
          height: _status ? 300 : 200,
          color: _status ? Colors.white : Colors.purpleAccent,
          child: Image.asset("images/logo.png"),
          duration: Duration(seconds: 2),
          curve: Curves.elasticInOut,
        ),
        RaisedButton(
          child: Text("Alterar"),
          onPressed: (){
            setState(() {
              _status = !_status;
            });
          },
        )
      ],
    );

  }

}