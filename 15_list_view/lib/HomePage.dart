/*
  Sabrina Karen
 */

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List _listToTest = [];

  void _putItems(){

    for (int i=0; i<10; i++){
      Map<String, dynamic> item = Map();
      item["titulo"] = "Título do item ${i}";
      item["descricao"] = "Descrição do item ${i}";
      _listToTest.add(item);
    }

  }

  @override
  Widget build(BuildContext context) {

    _putItems();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "List View"
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: _listToTest.length,
          itemBuilder: (contex, indice){
            return ListTile(
              title: Text( _listToTest[indice]["titulo"]),
              subtitle: Text( _listToTest[indice]["descricao"]),
            );
          },
        ),
      ),
    );

  }

}