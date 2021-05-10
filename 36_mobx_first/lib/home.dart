/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _value;

  _addValue() {
    setState(() {
      _value++;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _value = 0;
    });
  }

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
                Text(
                  '$_value',
                  style: TextStyle(
                    fontSize: 50,
                  ),
                ),
                ElevatedButton(
                  child: Text(
                    'Pressione',
                  ),
                  onPressed: () => _addValue(),
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }

}