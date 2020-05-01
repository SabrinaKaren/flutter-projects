/*
  Author: Sabrina Karen
*/

import 'package:caraoucoroa/HomePage.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {

  String choice;

  ResultPage(this.choice);

  @override
  _ResultPageState createState() => _ResultPageState();

}

class _ResultPageState extends State<ResultPage> {

  Image _coinResult = Image.asset("", width: 600);

  @override
  Widget build(BuildContext context) {

    if (widget.choice == "CARA"){
      _coinResult = Image.asset("images/moeda_cara.png", width: 200);
    } else {
      _coinResult = Image.asset("images/moeda_coroa.png", width: 200);
    }

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.lightGreen,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _coinResult,
            GestureDetector(
              child: Padding(
                padding: EdgeInsets.only(top: 30),
                child: Image.asset("images/botao_voltar.png", width: 160),
              ),
              onTap: (){
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );

  }

}