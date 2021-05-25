/*
  Sabrina Karen
*/

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:responsive_01/app/pages/home/home_page.dart';

void main() => runApp(
  DevicePreview(
    builder: (context) => MyApp(),
  ),
);

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      title: 'Curso de Flutter',
      builder: DevicePreview.appBuilder,
      locale: DevicePreview.locale(context),
    );

  }

}