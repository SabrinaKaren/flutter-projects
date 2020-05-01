/*
  Author: Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:formulario/HomePage.dart';

class ReturnPage extends StatefulWidget {

  String name;
  double weight;
  double height;

  ReturnPage(this.name, this.weight, this.height);

  @override
  _ReturnPageState createState() => _ReturnPageState();

}

class _ReturnPageState extends State<ReturnPage> {

  String _msgError = "Não foi possível calcular seu IMC!";
  double _imcValue = null;
  TextStyle _detailStyle = TextStyle();

  void _calculateImc(double weight, double height){
    if (weight != null && height != null){
      _imcValue = weight / (height * height); // Peso ÷ Altura²
    }
  }

  String _buildMsgImc(){

    // chamando a função que calcula o IMC
    this._calculateImc(widget.weight, widget.height);

    if (_imcValue == null){
      return _msgError;
    } else {
      return "Seu IMC é: " + _imcValue.toStringAsFixed(4);
    }

  }

  String _buildDetail(){

    if (_imcValue == null){
      return "";
    } else {
      if (_imcValue <= 18.5){ // <= 18.5 ... Abaixo do peso
        setState(() {
          _detailStyle = TextStyle(color: Colors.yellow, fontSize: 16, fontWeight: FontWeight.bold);
        });
        return "Você está abaixo do peso!";
      } else if (_imcValue > 18.5 && _imcValue <= 24.9){ // > 18.5 <= 24.9 ... Peso normal
        setState(() {
          _detailStyle = TextStyle(color: Colors.blue, fontSize: 17, fontWeight: FontWeight.bold);
        });
        return "Você está no peso normal!";
      } else if (_imcValue > 24.9 && _imcValue <= 29.9){ // > 24.9 <= 29.9 ... Sobrepeso
        setState(() {
          _detailStyle = TextStyle(color: Colors.red, fontSize: 19, fontWeight: FontWeight.bold);
        });
        return "Você está sobrepeso!";
      } else if (_imcValue > 29.9 && _imcValue <= 34.9){ // > 29.9 <= 34.9 ... Obesidade grau 1
        setState(() {
          _detailStyle = TextStyle(color: Colors.red, fontSize: 21, fontWeight: FontWeight.bold);
        });
        return "Você está com obesidade de grau 1!";
      } else if (_imcValue > 34.9 && _imcValue <= 39.9){ // > 29.9 <= 39.9 ... Obesidade grau 2
        setState(() {
          _detailStyle = TextStyle(color: Colors.red, fontSize: 22, fontWeight: FontWeight.bold);
        });
        return "Você está com obesidade de grau 2!";
      } else if (_imcValue > 40){ // > 40 ... Obesidade grau 3
        setState(() {
          _detailStyle = TextStyle(color: Colors.red, fontSize: 23, fontWeight: FontWeight.bold);
        });
        return "Você está com obesidade de grau 3!";
      }
    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Calcule seu IMC"),
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
                "Seja bem-vindo, ${widget.name}!",
              style: TextStyle(
                color: Colors.indigo,
                fontWeight: FontWeight.bold,
                fontSize: 21
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Text(
                _buildMsgImc(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Text(
                _buildDetail(),
                style: _detailStyle,
              )
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: RaisedButton(
                child: Text(
                  "Voltar",
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                color: Colors.indigo,
              ),
            )
          ],
        ),
      ),
    );

  }

}
