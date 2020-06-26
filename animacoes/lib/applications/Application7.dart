/*
  Sabrina Karen
  Desc.:
*/

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  AnimationController _animationController;
  AnimationStatus _animationStatus;

  @override
  void initState() {

    super.initState();

    _animationController = AnimationController(
        duration: Duration(seconds: 5),
        vsync: this
    )..repeat()..addStatusListener((status){
      _animationStatus = status;
    });

  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.white,
      child: Column(children: <Widget>[
        Container(
          width: 300,
          height: 400,
          child: RotationTransition(
            alignment: Alignment.center,
            child: Image.asset("images/logo.png"),
            turns: _animationController,
          ),
        ),
        RaisedButton(
          child: Text("Pressione"),
          onPressed: (){

            if(_animationStatus == AnimationStatus.dismissed){
              _animationController.repeat();
            }else{
              _animationController.reverse();
            }

          },
        )
      ],),
    );

  }

}