/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:olx/RouteGenerator.dart';
import 'package:olx/views/AdsPage.dart';

final ThemeData defaultTheme = ThemeData(
  primaryColor: Color(0xff9c27b0),
  accentColor: Color(0xff7b1fa2)
);

void main() => runApp(MaterialApp(
  title: "OLX",
  home: AdsPage(),
  theme: defaultTheme,
  initialRoute: "/",
  onGenerateRoute: RouteGenerator.generateRoute,
  debugShowCheckedModeBanner: false,
));