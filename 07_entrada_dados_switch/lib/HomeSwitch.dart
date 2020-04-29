import 'package:flutter/material.dart';

class HomeSwitch extends StatefulWidget {
  @override
  _HomeSwitchState createState() => _HomeSwitchState();
}

class _HomeSwitchState extends State<HomeSwitch> {

  IconData _iconResult = Icons.threesixty;
  bool _switchSelected = false;
  String _globalMsg = "";
  TextStyle _globalStyleMsg = TextStyle();

  void _showMsg(){

    if (_switchSelected){
      setState(() {
        _globalMsg = "Em breve lhe enviaremos um e-mail!";
        _globalStyleMsg = TextStyle(fontSize: 15, color: Colors.green);
        _iconResult = Icons.insert_emoticon;
      });
    } else {
      setState(() {
        _globalMsg = "Nenhum e-mail lhe será enviado!";
        _globalStyleMsg = TextStyle(fontSize: 15, color: Colors.red);
        _iconResult = Icons.mood_bad;
      });
    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Entrada de dados - switch"
        ),
        backgroundColor: Colors.grey,
      ),
      body: Container(
        child: SingleChildScrollView(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top:30, bottom: 20),
                    child: SwitchListTile(
                      title: Text("Receber nossos e-mails"),
                      value: _switchSelected,
                      onChanged: (bool valueScreen){
                        setState(() {
                          _switchSelected = valueScreen;
                        });
                        _showMsg();
                      },
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(25),
                      child: Row(
                        children: <Widget>[
                          Icon(_iconResult),
                          Padding(padding: EdgeInsets.all(4)),
                          Text(
                            _globalMsg,
                            style: _globalStyleMsg,
                          ),
                        ],
                      )
                  ),
                ],
              ),
            ),
        ),
      )
    );

  }

}