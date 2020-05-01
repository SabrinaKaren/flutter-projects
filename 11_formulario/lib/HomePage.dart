/*
  Author: Sabrina Karen
*/

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:formulario/ReturnPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    TextEditingController _controllerName = TextEditingController();
    TextEditingController _controllerWeight = TextEditingController();
    TextEditingController _controllerHeight = TextEditingController();

    void _sendData(){
      double weight = double.tryParse(_controllerWeight.text);
      double height = double.tryParse(_controllerHeight.text);
      Navigator.push(context, MaterialPageRoute(builder: (context) => ReturnPage(_controllerName.text, weight, height)));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Calcule seu IMC"),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: "Informe seu nome"
              ),
              keyboardType: TextInputType.text,
              controller: _controllerName,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  width: 120,
                  child: TextFormField(
                      decoration: InputDecoration(
                          labelText: "Peso"
                      ),
                      keyboardType: TextInputType.number,
                      controller: _controllerWeight,
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: TextFormField(
                      decoration: InputDecoration(
                          labelText: "Altura"
                      ),
                      keyboardType: TextInputType.number,
                      controller: _controllerHeight,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: RaisedButton(
              child: Text(
                "Calcular",
                style: TextStyle(
                  color: Colors.white
                ),
              ),
              onPressed: _sendData,
              color: Colors.indigo,
            ),
          ),
        ],
      ),
    );

  }

}