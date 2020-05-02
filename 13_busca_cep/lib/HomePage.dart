/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController _cepInputted = TextEditingController();
  String _completeAddress = "";

  void _searchCep() async {

    String url = "https://viacep.com.br/ws/${_cepInputted.text}/json/";
    http.Response response;
    String _completeAddressProv = "";

    response = await http.get(url);
    Map<String, dynamic> apiReturn = json.decode(response.body);
    String cep = apiReturn["cep"];
    String street = apiReturn["logradouro"];
    String neighborhood = apiReturn["bairro"];
    String city = apiReturn["localidade"];
    String uf = apiReturn["uf"];

    _completeAddressProv = "Cep: " + cep + "\n\n";
    _completeAddressProv += "Rua: " + street + "\n\n";
    _completeAddressProv += "Bairro: " + neighborhood + "\n\n";
    _completeAddressProv += "Cidade: " + city + "\n\n";
    _completeAddressProv += "Estado: " + uf;

    setState(() {
      _completeAddress = _completeAddressProv;
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Consulta CEP"
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20),
                child: TextField(
                  //textAlign: TextAlign.left,
                  keyboardType: TextInputType.number,
                  maxLengthEnforced: true,
                  maxLength: 8,
                  decoration: InputDecoration(
                      labelText: "Insira o CEP"
                  ),
                  controller: _cepInputted,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: RaisedButton(
                  child: Text(
                    "Buscar",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white
                    ),
                  ),
                  onPressed: _searchCep,
                  color: Colors.blueAccent,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  _completeAddress,
                  style: TextStyle(
                      fontSize: 15
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );

  }

}