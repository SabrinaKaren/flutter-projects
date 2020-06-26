/*
  Sabrina Karen
  Desc.: aplicando filtro dinâmico em imagem
*/

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  static final color = ColorTween(begin: Colors.white, end: Colors.orange);

  @override
  Widget build(BuildContext context) {

    return Center(
      child: TweenAnimationBuilder(
        duration: Duration(seconds: 2),
        tween: color,
        child: Image.asset("images/estrelas.jpg"),
        builder: (BuildContext context, Color cor, Widget widget){
          return ColorFiltered(
            colorFilter: ColorFilter.mode(cor, BlendMode.overlay),
            child: widget,
          );
        },
      ),
    );

  }

}