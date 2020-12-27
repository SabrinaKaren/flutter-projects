/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:getwhatsapp/home_page/home_controller.dart';
import 'package:getwhatsapp/home_page/home_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeController>.value(value: HomeController())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeView(),
      ),
    ),
  );
}