/*
  Sabrina Karen
*/

import 'package:abas/AccountPage.dart';
import 'package:abas/EmailPage.dart';
import 'package:abas/HomePage.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {

  TabController _tabController;

  @override
  void initState() {

    super.initState();

    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: 0
    );

  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Abas"),
        backgroundColor: Colors.lightBlueAccent,
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.home),
            ),
            Tab(
              icon: Icon(Icons.email),
            ),
            Tab(
              icon: Icon(Icons.account_circle),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          HomePage(),
          EmailPage(),
          AccountPage()
        ],
      )
    );

  }

}