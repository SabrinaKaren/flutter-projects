/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:navegation/SecondaryScreen.dart';
import 'PrimaryScreen.dart';

void main(){
  runApp(MaterialApp(
    initialRoute: "/",
    routes: {
      "/secundaria": (context) => SecondaryScreen(),
    },
    debugShowCheckedModeBanner: false,
    home: PrimaryScreen(),
  ));
}