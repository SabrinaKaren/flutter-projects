/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import '../../app_bar/app_bar_widget.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  Widget build(BuildContext context) {

    print('activeBreakpoint: ' + ResponsiveWrapper.of(context).activeBreakpoint.name);

    return Scaffold(
      backgroundColor: Color(0xFFF3F2EF),
      appBar: PreferredSize(child: AppBarWidget(), preferredSize: Size(double.infinity, 52)),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1000),
          child: Container(
            color: Colors.red,
          ),
        ),
      ),
    );

  }

}