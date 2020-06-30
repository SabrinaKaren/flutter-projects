/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';

class StandardButton extends StatelessWidget {

  final String text;
  final Color textColor;
  final VoidCallback onPressed;

  StandardButton({
    @required this.text,
    this.textColor = Colors.white,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {

    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6)
      ),
      child: Text(
        this.text,
        style: TextStyle(
            color: this.textColor,
            fontSize: 20,
        ),
      ),
      color: Color(0xff9c27b0),
      padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
      onPressed: this.onPressed,
    );

  }

}