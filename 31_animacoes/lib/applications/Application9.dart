/*
  Sabrina Karen
  Desc.: utilizando animated builder
*/

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        duration: Duration(seconds: 2),
        vsync: this
    );

    _animation = Tween<Offset>(
        begin: Offset(0,0),
        end: Offset(60,0)
    ).animate(_animationController);

  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    _animationController.forward();

    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: AnimatedBuilder(
        animation: _animation,
        child: Stack(
          children: <Widget>[
            Positioned(
              width: 180,
              height: 180,
              left: 0,
              top: 0,
              child: Image.asset("images/logo.png"),
            )
          ],
        ),
        builder: (context, widget){

          return Transform.translate(
            offset: _animation.value,
            child: widget,
          );

        },
      ),
    );
  }

}