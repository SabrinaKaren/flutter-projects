/*
  Sabrina Karen
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/HomePage.dart';
import 'package:whatsapp/LoginPage.dart';
import 'package:whatsapp/RegisterPage.dart';
import 'package:whatsapp/SettingsPage.dart';

class CommonMethods{

  static Route<dynamic> generateRoute(RouteSettings settings){

    switch( settings.name ){
      case "/" :
        return MaterialPageRoute(
            builder: (_) => Login()
        );
      case "/login" :
        return MaterialPageRoute(
            builder: (_) => Login()
        );
      case "/cadastro" :
        return MaterialPageRoute(
            builder: (_) => Register()
        );
      case "/home" :
        return MaterialPageRoute(
            builder: (_) => HomePage()
        );
      case "/config" :
        return MaterialPageRoute(
            builder: (_) => SettingsPage()
        );
      default:
        _errorRoute();
    }

  }

  static Route<dynamic> _errorRoute(){
    return MaterialPageRoute(
        builder: (_){
          return Scaffold(
            appBar: AppBar(title: Text("Tela não encontrada!"),),
            body: Center(
              child: Text("Tela não encontrada!"),
            ),
          );
        }
    );
  }

}