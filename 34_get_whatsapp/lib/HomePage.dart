/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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
          child: 
        )
      ),
    );
  }

}