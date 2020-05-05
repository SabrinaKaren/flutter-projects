/*
  Sabrina Karen
 */

import 'package:flutter/material.dart';

class RisingPage extends StatefulWidget {
  @override
  _RisingPageState createState() => _RisingPageState();
}

class _RisingPageState extends State<RisingPage> {
  @override
  Widget build(BuildContext context) {

    return Container(
      child: Center(
        child: Text(
          "Tela em alta",
          style: TextStyle(
              fontSize: 25
          ),
        ),
      ),
    );

  }
}
