/*
  Sabrina Karen
 */

import 'package:flutter/material.dart';
import 'package:youtube/CustomSearchDelegate.dart';
import 'package:youtube/InscriptionPage.dart';
import 'package:youtube/LibraryPage.dart';
import 'package:youtube/RisingPage.dart';
import 'package:youtube/StartPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentIndex = 0;
  String _result = "";

  @override
  Widget build(BuildContext context) {

    List<Widget> pages = [
      StartPage(_result),
      RisingPage(),
      InscriptionPage(),
      LibraryPage()
    ];

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey,
        ),
        title: Image.asset("images/youtube.png", width: 98,),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: (){},
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String resultFromFunction = await showSearch(
                  context: context,
                  delegate: CustomSearchDelegate()
              );
              setState(() {
                _result = resultFromFunction;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: (){},
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: pages[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        fixedColor: Colors.red,
        type: BottomNavigationBarType.fixed,
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            title: Text("Início"),
            icon: Icon(Icons.home)
          ),
          BottomNavigationBarItem(
              title: Text("Em alta"),
              icon: Icon(Icons.whatshot)
          ),
          BottomNavigationBarItem(
              title: Text("Incrições"),
              icon: Icon(Icons.subscriptions)
          ),
          BottomNavigationBarItem(
              title: Text("Biblioteca"),
              icon: Icon(Icons.folder)
          ),
        ]
      ),
    );

  }

}