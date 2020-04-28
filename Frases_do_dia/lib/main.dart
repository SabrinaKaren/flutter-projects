import 'dart:math';

import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var _title = "Frases do Dia";
  var _phrase = "Frase inicial";
  List _phrasesList = [
    'O importante não é vencer todos os dias, mas lutar sempre.',
    'Maior que a tristeza de não haver vencido é a vergonha de não ter lutado!',
    'É melhor conquistar a si mesmo do que vencer mil batalhas.',
    'Quem ousou conquistar e saiu pra lutar, chega mais longe!',
    'Quem ousou conquistar e saiu pra lutar, chega mais longe!',
    'Enquanto houver vontade de lutar haverá esperança de vencer.',
    'Difícil é ganhar um amigo em uma hora; fácil é ofendê-lo em um minuto.',
    'O medo de perder tira a vontade de ganhar.',
    'Escolher o seu tempo é ganhar tempo.',
    'Perder para a razão, sempre é ganhar.'
  ];

  void getNewPhrase(){
    setState(() {
      _phrase = _phrasesList[new Random().nextInt(_phrasesList.length)];
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text( _title ),
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset("images/logo.png"),
                Text(
                  _phrase,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18
                  ),
                ),
                RaisedButton(
                  child: Text(
                    "Nova frase",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  color: Colors.green,
                  onPressed: getNewPhrase,
                )
              ],
            ),
          ),
        )
    );

  }

}