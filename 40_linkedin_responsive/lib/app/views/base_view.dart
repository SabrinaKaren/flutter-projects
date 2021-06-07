/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:linkedin_responsive/app/views/home/home_view.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import '../views/app_bar/app_bar_widget.dart';

class BaseView extends StatefulWidget {
  @override
  _BaseViewState createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {

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
          child: HomeView(),
        ),
      ),
    );

  }

}