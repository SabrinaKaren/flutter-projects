/*
  Sabrina Karen
  Desc.: rotacionando uma imagem através de tween e angulos
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
        duration: Duration(seconds: 2),
        tween: Tween<double>(begin: 0, end: 6.28),
        builder: (BuildContext context, double angule, Widget widget){
          return Transform.rotate(
            angle: angule,
            child: Image.asset("images/logo.png"),
          );
        },
      ),
    );

  }

}