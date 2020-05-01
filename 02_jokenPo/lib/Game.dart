/*
  Author: Sabrina Karen
*/

import 'dart:math';
import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {

  var _appChoiceImage = AssetImage("images/padrao.png");
  var _msgReturn = "Escolha uma opção abaixo";
  var _msgStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orangeAccent);

  void _userWon(){
    setState(() {
      this._msgStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green);
      this._msgReturn = "Você ganhou! :D";
    });
  }

  void _appWon(){
    setState(() {
      this._msgStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red);
      this._msgReturn = "Você perdeu! :(";
    });
  }

  void _equals(){
    setState(() {
      this._msgStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepOrangeAccent);
      this._msgReturn = "Empatamos ;)";
    });
  }

  void _executeGame(String userChoice){

    var options = ["PEDRA", "PAPEL", "TESOURA"];
    var appChoice = options[Random().nextInt(3)];

    // trocar a imagem da escolha do app (gerada randomicamente)
    switch(appChoice){

      case "PEDRA":
        setState(() {
          this._appChoiceImage = AssetImage("images/pedra.png");
        });
        break;

      case "PAPEL":
        setState(() {
          this._appChoiceImage = AssetImage("images/papel.png");
        });
        break;

      case "TESOURA":
        setState(() {
          this._appChoiceImage = AssetImage("images/tesoura.png");
        });
        break;

    }

    // analisando ganhador
    if ((userChoice == "PEDRA" && appChoice == "TESOURA") ||
        (userChoice == "PAPEL" && appChoice == "PEDRA") ||
        (userChoice == "TESOURA" && appChoice == "PAPEL")){
      this._userWon();
    } else if ((appChoice == "PEDRA" && userChoice == "TESOURA") ||
        (appChoice == "PAPEL" && userChoice == "PEDRA") ||
        (appChoice == "TESOURA" && userChoice == "PAPEL")){
      this._appWon();
    } else if ((appChoice == "PEDRA" && userChoice == "PEDRA") ||
        (appChoice == "PAPEL" && userChoice == "PAPEL") ||
        (appChoice == "TESOURA" && userChoice == "TESOURA")){
      this._equals();
    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Pedra, papel, tesoura"),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 32, bottom: 16),
            child: Text(
              "Escolha do app",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.orangeAccent
              ),
            ),
          ),
          Image(image: _appChoiceImage),
          Padding(
            padding: EdgeInsets.only(top: 32, bottom: 16),
            child: Text(
              this._msgReturn,
              textAlign: TextAlign.center,
              style: _msgStyle
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () => _executeGame("PEDRA"),
                child: Image.asset("images/pedra.png", height: 100),
              ),
              GestureDetector(
                onTap: () => _executeGame("PAPEL"),
                child: Image.asset("images/papel.png", height: 100),
              ),
              GestureDetector(
                onTap: () => _executeGame("TESOURA"),
                child: Image.asset("images/tesoura.png", height: 100),
              )
            ],
          )
        ],
      ),
    );

  }

}