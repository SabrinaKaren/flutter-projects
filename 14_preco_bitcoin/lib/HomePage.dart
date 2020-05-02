/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String _bitcoinValue = "";

  void _getBitCoinValue() async {

    String url = "https://blockchain.info/ticker";
    http.Response bitCoinReturned = await http.get(url);

    Map<String, dynamic> bitCoinReturnedBody = jsonDecode(bitCoinReturned.body);
    setState(() {
      _bitcoinValue = "R\$ " + bitCoinReturnedBody["BRL"]["buy"].toString();
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("images/bitcoin.png"),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                _bitcoinValue,
                style: TextStyle(
                  fontSize: 35,
                ),
              ),
            ),
            RaisedButton(
              child: Text(
                "Atualizar",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              ),
              color: Colors.orange,
              onPressed: _getBitCoinValue,
            )
          ],
        ),
      ),
    );

  }

}