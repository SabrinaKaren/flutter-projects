/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:getwhatsapp/home_page/home_bloc.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  HomeBloc _bloc = HomeBloc();

  @override
  Widget build(BuildContext context) {

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Get WhatsApp'),
          backgroundColor: Color(0xff075e54),
        ),
        body: Padding(
          padding: EdgeInsets.all(screenHeight * 0.04),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _bloc.numberController,
                cursorColor: Color(0xff075e54),
                keyboardType: TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(screenHeight * 0.022),
                  hintText: '(31) 9 9999-9999',
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Número',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.04),
                child: Wrap(
                  spacing: screenWidth * 0.1,
                  children: [
                    RaisedButton(
                      child: Text(
                        'Gerar',
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                      color: Color(0xff075e54),
                      onPressed: () => _bloc.generateLink(),
                    ),
                    RaisedButton(
                      child: Text(
                        'Abrir',
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                      color: Color(0xff075e54),
                      onPressed: () => _bloc.openLink(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.05),
                child: InkWell(
                  child: Text(
                    _bloc.link,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: screenHeight * 0.03,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onTap: () => _bloc.launchLink(),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }

}