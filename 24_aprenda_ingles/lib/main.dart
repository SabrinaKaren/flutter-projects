/*
  Sabrina Karen
*/

import 'package:aprendaingles/HomePage.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
    theme: ThemeData(
      primaryColor: Color(0xff795548),
      scaffoldBackgroundColor: Color(0xfff5e9b9)
    ),
  ));
}