/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:olx/HomePage.dart';

final ThemeData defaultTheme = ThemeData(
    primaryColor: Color(0xff9c27b0),
    accentColor: Color(0xff7b1fa2)
);

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Olx",
    home: HomePage(),
  ));
}