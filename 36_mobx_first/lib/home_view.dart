/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_first/home_controller.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  HomeController _homeController = HomeController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Observer(
                  builder: (_) {
                    return Text(
                      "${_homeController.counter}",
                      style: TextStyle(
                        fontSize: 50,
                      ),
                    );
                  },
                ),
                ElevatedButton(
                  child: Text(
                    'Pressione',
                  ),
                  onPressed: () => _homeController.increment(),
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }

}