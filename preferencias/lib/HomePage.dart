/*
  Sabrina Karen
 */

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String _savedText = "Nada salvo";
  TextEditingController _fieldController = TextEditingController();

  void _save() async {

    var _typedValue = _fieldController.text;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("name", _typedValue);

  }

  void _read() async {

    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedText = prefs.getString("name") ?? "Sem valor";
    });

  }

  void _remove() async {

    final prefs = await SharedPreferences.getInstance();
    prefs.remove("name");

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Manipulação de dados"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Text(
              _savedText,
            ),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: "Digite algo"
              ),
              controller: _fieldController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RaisedButton(
                  child: Text(
                      "Salvar",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                  ),
                  color: Colors.blue,
                  onPressed: _save,
                ),
                RaisedButton(
                  child: Text(
                    "Ler",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  color: Colors.blue,
                  onPressed: _read,
                ),
                RaisedButton(
                  child: Text(
                    "Remover",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  color: Colors.blue,
                  onPressed: _remove,
                ),
              ],
            )
          ],
        ),
      ),
    );

  }

}
