/*
  Author: Sabrina Karen
*/

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _alcoholController = TextEditingController();
  TextEditingController _gasolineController = TextEditingController();
  String _result = "";

  void _calculete(){

    double alcoholValue = double.tryParse(_alcoholController.text);
    double gasolineValue = double.tryParse(_gasolineController.text);

    if (alcoholValue == null || gasolineValue == null){
      setState(() {
        _result = "Preço inválido, digite números maiores que 0, e utilize ponto em vez de vírgula";
      });
    } else {
      /*
        Regra: se alcool dividido por gasolina for >= 0.7, gasolina é a melhor opção
      */
      if (alcoholValue/gasolineValue >= 0.7){
        setState(() {
          _result = "Gasolina é a melhor opção para o seu abastecimento!";
        });
      } else {
        setState(() {
          _result = "Álcool é a melhor opção para o seu abastecimento!";
        });
      }
    }

    _cleanFields();

  }

  void _cleanFields(){
    _alcoholController.text = "";
    _gasolineController.text = "";
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Álcool ou gasolina"
        ),
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        child: SingleChildScrollView(
            padding: EdgeInsets.all(32),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(30),
                      child: Image.asset("images/logo.png")
                  ),
                  Text(
                    "Saiba qual a melhor opção para o abastecimento do seu carro",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87
                    ),
                    textAlign: TextAlign.center,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        labelText: "Preço do álcool. Ex.: 1.59"
                    ),
                    keyboardType: TextInputType.number,
                    controller: _alcoholController,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        labelText: "Preço da gasolina. Ex.: 1.59"
                    ),
                    keyboardType: TextInputType.number,
                    controller: _gasolineController,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: RaisedButton(
                        color: Colors.indigo,
                        child: Text(
                          "Calcular",
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                        onPressed: _calculete,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      _result,
                      style: TextStyle(
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                ],
              ),
            )
        ),
      ),
    );

  }

}