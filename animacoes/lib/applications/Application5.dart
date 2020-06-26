/*
  Sabrina Karen
  Desc.: expandindo container
*/

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    return Center(
      child: TweenAnimationBuilder(
        duration: Duration(seconds: 1),
        tween: Tween<double>(begin: 50, end: 180),
        builder: (BuildContext context, double width, Widget widget){
          return Container(
            color: Colors.green,
            width: width,
            height: 60,
          );
        },
      ),
    );

  }

}