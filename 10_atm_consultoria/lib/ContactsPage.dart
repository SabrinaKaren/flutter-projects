/*
  Author: Sabrina Karen
*/

import 'package:flutter/material.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("Entre em contato conosco"),
          backgroundColor: Colors.green,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(25),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Image.asset("images/detalhe_contato.png"),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        "Contato",
                        style: TextStyle(
                            color: Colors.lightGreen,
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.mail,
                              color: Colors.lightGreen,
                            ),
                            Text(
                              "  consultoria.contato@atm.com.br",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            )
                          ],
                        ),
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(
                              Icons.phone,
                              color: Colors.lightGreen,
                            ),
                            Text(
                              "  (31) 3333-3333",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            )
                          ],
                        ),
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(
                              Icons.phone_android,
                              color: Colors.lightGreen,
                            ),
                            Text(
                              "  (31) 9 8888-8888",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            )
                          ],
                        ),
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(
                              Icons.language,
                              color: Colors.lightGreen,
                            ),
                            Text(
                              "  www.consultoriaatm.com.br",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                ),
              ],
            ),
          ),
        )
    );

  }

}