/*
  Sabrina Karen
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linkedin_responsive/app/views/home/widgets/timeline/timeline_widget.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(20),
      child: TimeLine(),
    );

  }

}