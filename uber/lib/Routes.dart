/*
  Sabrina Karen
 */

import 'package:flutter/material.dart';
import 'package:uber/Pages/DriverPage.dart';
import 'package:uber/Pages/HomePage.dart';
import 'package:uber/Pages/PassengerPage.dart';
import 'package:uber/Pages/RegisterPage.dart';
import 'package:uber/Pages/RunPage.dart';

class Routes {

  static Route<dynamic> generateRoutes(RouteSettings settings){

    final args = settings.arguments;

    switch( settings.name ){
      case "/" :
        return MaterialPageRoute(
            builder: (_) => HomePage()
        );
      case "/cadastro" :
        return MaterialPageRoute(
            builder: (_) => RegisterPage()
        );
      case "/motorista" :
        return MaterialPageRoute(
            builder: (_) => DriverPage()
        );
      case "/passageiro" :
        return MaterialPageRoute(
            builder: (_) => PassengerPage()
        );
      case "/corrida" :
        return MaterialPageRoute(
            builder: (_) => RunPage(
                args
            )
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