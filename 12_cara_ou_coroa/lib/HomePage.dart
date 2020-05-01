/*
  Author: Sabrina Karen
*/

import 'dart:math';

import 'package:caraoucoroa/ResultPage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void _choiceSide(){

    List coinList = ["CARA", "COROA"];
    String choice = coinList[Random().nextInt(2)];
    
    Navigator.push(context, MaterialPageRoute(builder: (context) => ResultPage(choice)));

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.lightGreen,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("images/logo.png", width: 600),
            GestureDetector(
              child: Image.asset("images/botao_jogar.png", width: 160),
              onTap: _choiceSide,
            ),
          ],
        ),
      ),
    );

  }

}