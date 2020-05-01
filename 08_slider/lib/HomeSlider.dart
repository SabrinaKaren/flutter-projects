/*
  Author: Sabrina Karen
*/

import 'package:flutter/material.dart';

class HomeSlider extends StatefulWidget {
  @override
  _HomeSliderState createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {

  double _sliderValue = 3;
  String _imagePath = "images/emotion_2_3.png";

  void _send(){

    String _imagePathProv = "";

    if (_sliderValue <= 1 ){
      _imagePathProv = "images/emotion_0_1.png";
    } else if (_sliderValue > 1 && _sliderValue <= 2 ){
      _imagePathProv = "images/emotion_1_2.png";
    } else if (_sliderValue > 2 && _sliderValue <= 3 ){
      _imagePathProv = "images/emotion_2_3.png";
    } else if (_sliderValue > 3 && _sliderValue <= 4 ){
      _imagePathProv = "images/emotion_3_4.png";
    } else if (_sliderValue > 4 && _sliderValue <= 5 ){
      _imagePathProv = "images/emotion_4_5.png";
    } else {
      _imagePathProv = "images/emotion_4_5.png";
    }

    setState(() {
      _imagePath = _imagePathProv;
    });

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
                    padding: EdgeInsets.all(30),
                    child: Text(
                      "Selecione seu grau de satisfação com nossos serviços",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Slider(
                      value: _sliderValue,
                      min: 1,
                      max: 5,
                      label: _sliderValue.toString(),
                      divisions: 4,
                      activeColor: Colors.blueGrey,
                      onChanged: (double value){
                        setState(() {
                          _sliderValue = value;
                        });
                      }
                  ),
                  Column(
                    children: <Widget>[
                      RaisedButton(
                        child: Text(
                          "Enviar",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        onPressed: _send,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Image.asset(_imagePath, width: 70,),
                      ),
                    ],
                  )
                ],
              ),
            ),
        ),
      )
    );

  }

}