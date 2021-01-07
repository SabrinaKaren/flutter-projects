/*
  Sabrina Karen
*/

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeBloc {

  TextEditingController numberController = TextEditingController();
  String _baseUrl = "https://api.whatsapp.com/send?1=pt_BR&phone=55";

  // controles para a exibição do link na tela
  String link = "";
  StreamController _strCtrlLink = StreamController();
  Stream get outputLink => _strCtrlLink.stream;
  StreamSink get _inputLink => _strCtrlLink.sink;

  generateLink() {
    link = _baseUrl + numberController.text;
    _inputLink.add(link);
  }

  openLink() {
    link = _baseUrl + numberController.text;
    _inputLink.add(link);
    launchLink();
  }

  launchLink() async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      throw 'Não foi possível lançar: $link';
    }
  }

  dispose() {
    _strCtrlLink.close();
  }

}