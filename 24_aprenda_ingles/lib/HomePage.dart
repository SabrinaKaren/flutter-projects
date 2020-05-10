/*
  Sabrina Karen
*/

import 'package:aprendaingles/AnimalsTab.dart';
import 'package:aprendaingles/NumbersTab.dart';
import 'package:aprendaingles/VowelsTab.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

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
        title: Text("Aprenda inglês"),
        bottom: TabBar(
          controller: _tabController,
          indicatorWeight: 4,
          indicatorColor: Colors.white,
          tabs: <Widget>[
            Tab(
              text: "Bichos",
            ),
            Tab(
              text: "Números",
            ),
            Tab(
              text: "Vogais",
            ),
          ],
        )
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          AnimalsTab(),
          NumbersTab(),
          VowelsTab(),
        ],
      ),
    );

  }

}