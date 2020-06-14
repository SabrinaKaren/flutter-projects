/*
  Sabrina Karen
 */

import 'package:flutter/material.dart';
import 'package:uber/Pages/HomePage.dart';
import 'package:uber/Pages/RegisterPage.dart';

class Routes {

  static Route<dynamic> generateRoutes(RouteSettings settings){

    switch( settings.name ){
      case "/" :
        return MaterialPageRoute(
            builder: (_) => HomePage()
        );
      case "/cadastro" :
        return MaterialPageRoute(
            builder: (_) => RegisterPage()
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