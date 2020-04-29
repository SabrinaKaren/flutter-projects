import 'package:flutter/material.dart';

class HomeCheckBox extends StatefulWidget {
  @override
  _HomeCheckBoxState createState() => _HomeCheckBoxState();
}

class _HomeCheckBoxState extends State<HomeCheckBox> {

  var _mainTxtStyle = TextStyle( color: Colors.black45, fontWeight: FontWeight.bold, fontSize: 18 );
  String _msgReturn = "";
  double _totalValue = 0;

  bool _lipstickIsSelected = false;
  bool _penIsSelected = false;
  bool _bookIsSelected = false;
  bool _laptopIsSelected = false;
  bool _cellIsSelected = false;

  double _lipstickValue = 10;
  double _penValue = 1.9;
  double _bookValue = 12.5;
  double _laptopValue = 2000;
  double _cellValue = 999.99;

  void _finish(){

    if (_lipstickIsSelected) _totalValue += _lipstickValue;
    if (_penIsSelected) _totalValue += _penValue;
    if (_bookIsSelected) _totalValue += _bookValue;
    if (_laptopIsSelected) _totalValue += _laptopValue;
    if (_cellIsSelected) _totalValue += _cellValue;

    setState(() {
      _msgReturn = "Valor total: " + _totalValue.toString();
    });

    _totalValue = 0;

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Entrada de dados - check-box"
        ),
        backgroundColor: Colors.grey,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 30, left: 30),
              child: Text(
                "Escolha os itens a serem comprados",
                style: _mainTxtStyle
              ),
            ),
            CheckboxListTile(
              secondary: Icon(Icons.brush),
              title: Text(
                "Batom",
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.normal,
                    fontSize: 16
                ),
                textAlign: TextAlign.right,
              ),
              subtitle: Text(
                "Valor: " + _lipstickValue.toString(),
                textAlign: TextAlign.right,
              ),
              value: _lipstickIsSelected,
              onChanged: (bool value){
                setState(() {
                  _lipstickIsSelected = value;
                });
              },
            ),
            CheckboxListTile(
              secondary: Icon(Icons.edit),
              title: Text(
                "Caneta",
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.normal,
                    fontSize: 16
                ),
                textAlign: TextAlign.right,
              ),
              subtitle: Text(
                "Valor: " + _penValue.toString(),
                textAlign: TextAlign.right,
              ),
              value: _penIsSelected,
              onChanged: (bool value){
                setState(() {
                  _penIsSelected = value;
                });
              },
            ),
            CheckboxListTile(
              secondary: Icon(Icons.book),
              title: Text(
                "Livro",
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.normal,
                    fontSize: 16
                ),
                textAlign: TextAlign.right,
              ),
              subtitle: Text(
                "Valor: " + _bookValue.toString(),
                textAlign: TextAlign.right,
              ),
              value: _bookIsSelected,
              onChanged: (bool value){
                setState(() {
                  _bookIsSelected = value;
                });
              },
            ),
            CheckboxListTile(
              secondary: Icon(Icons.laptop),
              title: Text(
                "Notebook",
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.normal,
                    fontSize: 16
                ),
                textAlign: TextAlign.right,
              ),
              subtitle: Text(
                "Valor: " + _laptopValue.toString(),
                textAlign: TextAlign.right,
              ),
              value: _laptopIsSelected,
              onChanged: (bool value){
                setState(() {
                  _laptopIsSelected = value;
                });
              },
            ),
            CheckboxListTile(
              secondary: Icon(Icons.phone_android),
              title: Text(
                "Celular",
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.normal,
                    fontSize: 16
                ),
                textAlign: TextAlign.right,
              ),
              subtitle: Text(
                "Valor: " + _cellValue.toString(),
                textAlign: TextAlign.right,
              ),
              value: _cellIsSelected,
              onChanged: (bool value){
                setState(() {
                  _cellIsSelected = value;
                });
              },
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    _msgReturn,
                    style: _mainTxtStyle,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 60),
                  child: RaisedButton(
                    child: Text(
                      "Finalizar",
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      ),
                    ),
                    onPressed: _finish,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );

  }

}
