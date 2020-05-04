/*
  Sabrina Karen
 */

import 'package:flutter/material.dart';

class LibraryPage extends StatefulWidget {
  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {

    return Container(
      child: Center(
        child: Text(
          "Tela biblioteca",
          style: TextStyle(
              fontSize: 25
          ),
        ),
      ),
    );

  }
}
