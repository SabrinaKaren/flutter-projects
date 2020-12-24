/*
  Sabrina Karen
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwhatsapp/home_page/home_controller.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  HomeController _controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Get WhatsApp'),
          backgroundColor: Color(0xff075e54),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              TextField(
                cursorColor: Color(0xff075e54),
                keyboardType: TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(15),
                  hintText: '(31) 9 9999-9999',
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Número',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: RaisedButton(
                  child: Text(
                    'Abrir',
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  color: Color(0xff075e54),
                  onPressed: () => _controller.generateLink('teste'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}