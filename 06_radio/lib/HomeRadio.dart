import 'package:flutter/material.dart';

class HomeRadio extends StatefulWidget {
  @override
  _HomeRadioState createState() => _HomeRadioState();
}

class _HomeRadioState extends State<HomeRadio> {

  String _userChoice;
  String _manMsg = "Seja bem-vindo sr. ";
  String _womanMsg = "Seja bem-vinda sra. ";
  String _globalMsg = "";
  IconData _iconShow = null;
  TextEditingController _name = TextEditingController();

  void _send(){

    if (_userChoice != null){
      if (_userChoice == "M"){
        setState(() {
          _globalMsg = _manMsg + _name.text;
          _iconShow = Icons.accessibility_new;
        });
      } else if (_userChoice == "F"){
        setState(() {
          _globalMsg = _womanMsg + _name.text;
          _iconShow = Icons.accessibility_new;
        });
      }
    }

  }

  @override
  Widget build(BuildContext context) {

    var _titleStyle = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Entrada de dados - radio"
        ),
        backgroundColor: Colors.grey,
      ),
      body: Container(
        child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top:30, bottom: 20),
                  child: Text(
                      "Selecione o gênero",
                      style: _titleStyle
                  ),
                ),
                RadioListTile(
                  title: Text("Masculino"),
                  value: "M",
                  groupValue: _userChoice,
                  onChanged: (String choice){
                    setState(() {
                      _userChoice = choice;
                    });
                  },
                ),
                RadioListTile(
                  title: Text("Feminino"),
                  value: "F",
                  groupValue: _userChoice,
                  onChanged: (String choice){
                    setState(() {
                      _userChoice = choice;
                    });
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    "Insira o nome",
                    style: _titleStyle,
                  ),
                ),
                Container(
                  child: TextField(
                    keyboardType: TextInputType.text,
                    controller: _name,
                  ),
                  width: 300,
                ),
                Padding(
                  padding: EdgeInsets.all(30),
                  child: RaisedButton(
                    child: Text("Enviar", style: TextStyle(color: Colors.white),),
                    onPressed: _send,
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(25),
                  child: Row(
                    children: <Widget>[
                      Icon(_iconShow),
                      Padding(padding: EdgeInsets.all(10)),
                      Text(
                        _globalMsg,
                        style: TextStyle(
                            fontSize: 20
                        ),
                      ),
                    ],
                  )
                ),
              ],
            ),
        ),
      )
    );

  }

}