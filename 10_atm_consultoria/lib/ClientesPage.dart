/*
  Author: Sabrina Karen
*/

import 'package:flutter/material.dart';

class ClientesPage extends StatefulWidget {
  @override
  _ClientesPageState createState() => _ClientesPageState();
}

class _ClientesPageState extends State<ClientesPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("Clientes"),
          backgroundColor: Colors.green,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(25),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Image.asset("images/detalhe_cliente.png"),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        "Nossos clientes",
                        style: TextStyle(
                            color: Colors.black,
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Image.asset("images/cliente1.png"),
                                Text(
                                    "Software",
                                  style: TextStyle(
                                    fontSize: 12
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Image.asset("images/cliente2.png"),
                                Text(
                                    "Pescaria",
                                  style: TextStyle(
                                      fontSize: 12
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Image.asset("images/cliente3.png"),
                                  Text(
                                      "Auditoria",
                                    style: TextStyle(
                                        fontSize: 12
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Image.asset("images/cliente4.png"),
                                  Text(
                                      "Internet",
                                    style: TextStyle(
                                        fontSize: 12
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
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