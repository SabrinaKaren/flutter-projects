/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeBloc {

  TextEditingController numberController = TextEditingController();
  String link = "";
  String _baseUrl = "https://api.whatsapp.com/send?1=pt_BR&phone=55";

  generateLink() {
    link = _baseUrl + numberController.text;
  }

  openLink() {
    link = _baseUrl + numberController.text;
    launchLink();
  }

  launchLink() async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      throw 'Não foi possível lançar: $link';
    }
  }

}