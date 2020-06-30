/*
  Sabrina Karen
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:olx/views/AdDetailsPage.dart';
import 'package:olx/views/AdsPage.dart';
import 'package:olx/views/LoginPage.dart';
import 'package:olx/views/MyAdsPage.dart';
import 'package:olx/views/NewAdPage.dart';

class RouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings){

    final args = settings.arguments;

    switch( settings.name ){
      case "/" :
        return MaterialPageRoute(
          builder: (_) => AdsPage()
        );
      case "/login" :
        return MaterialPageRoute(
            builder: (_) => LoginPage()
        );
      case "/meus-anuncios" :
        return MaterialPageRoute(
            builder: (_) => MyAdsPage()
        );
      case "/novo-anuncio" :
        return MaterialPageRoute(
            builder: (_) => NewAdPage()
        );
      case "/detalhes-anuncio" :
        return MaterialPageRoute(
            builder: (_) => AdDetailsPage(args)
        );
      default:
        _routeError();
    }

  }

  static Route<dynamic> _routeError(){

    return MaterialPageRoute(
      builder: (_){
        return Scaffold(
          appBar: AppBar(
            title: Text("Tela não encontrada!"),
          ),
          body: Center(
            child: Text("Tela não encontrada!"),
          ),
        );
      }
    );

  }

}