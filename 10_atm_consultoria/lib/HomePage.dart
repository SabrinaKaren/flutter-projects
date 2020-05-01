/*
  Author: Sabrina Karen
*/

import 'package:atmconsultoria/ClientesPage.dart';
import 'package:atmconsultoria/CompanyPage.dart';
import 'package:atmconsultoria/ContactsPage.dart';
import 'package:atmconsultoria/ServicesPage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void _goCompany(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => CompanyPage()));
  }

  void _goServices(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ServicesPage()));
  }

  void _goClients(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ClientesPage()));
  }
  void _goContact(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ContactsPage()));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("ATM Consultoria"),
        backgroundColor: Colors.green,
      ),
      body: Container(
        padding: EdgeInsets.only(top:40, left: 25, right: 25),
        child: Column(
          children: <Widget>[
            Image.asset("images/logo.png"),
            Padding(
              padding: EdgeInsets.only(top: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    child: Image.asset("images/menu_empresa.png"),
                    onTap: _goCompany,
                  ),
                  GestureDetector(
                    child: Image.asset("images/menu_servico.png"),
                    onTap: _goServices,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    child: Image.asset("images/menu_cliente.png"),
                    onTap: _goClients,
                  ),
                  GestureDetector(
                    child: Image.asset("images/menu_contato.png"),
                    onTap: _goContact,
                  ),
                ],
              ),
            )
          ],
        )
      ),
    );

  }

}