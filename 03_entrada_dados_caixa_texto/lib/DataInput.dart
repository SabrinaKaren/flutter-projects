/*
  Author: Sabrina Karen
*/

import 'dart:ffi';

import 'package:flutter/material.dart';

class DataInput extends StatefulWidget {
  @override
  _DataInputState createState() => _DataInputState();
}

class _DataInputState extends State<DataInput> {

  TextEditingController _textEditingController = TextEditingController();
  double _currentValue = 500.00;

  void _calculateBalance(){
    double valueToBeDebited = double.tryParse(_textEditingController.text);
    if (valueToBeDebited != null){
      setState(() {
        this._currentValue = _currentValue - valueToBeDebited;
      });
      _textEditingController.text = "";
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: Text(
              "Entrada de dados"
          ),
          backgroundColor: Colors.grey
      ),
      body: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(32),
              child: Text(
                "Saldo: " + _currentValue.toString(),
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                ),
              ),
          ),
          Padding(
              padding: EdgeInsets.all(32),
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Insira o valor a ser sacado",
                ),
                style: TextStyle(
                    fontSize: 20
                ),
                controller: _textEditingController,
              ),
          ),
          RaisedButton(
            child: Text("Salvar"),
            onPressed: (){ _calculateBalance(); },
          ),
        ],
      ),
    );

  }

}
