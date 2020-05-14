/*
  Sabrina Karen
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/HomePage.dart';

class CommonMethods{

  static goToHome(context){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage()
        )
    );
  }

  static goToHomeWithReplacement(context){
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage()
        )
    );
  }

}