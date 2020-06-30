/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:olx/data/UserData.dart';
import 'package:olx/views/widgets/StandardButton.dart';
import 'package:olx/views/widgets/StandardInput.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController _controllerEmail = TextEditingController(text: "sabrina@gmail.com");
  TextEditingController _controllerPassword = TextEditingController(text: "1234567");
  bool _register = false;
  String _errorMsg = "";
  String _buttonText = "Entrar";

  _registerUser(UserData user) {

    FirebaseAuth auth = FirebaseAuth.instance;

    auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password
    ).then((firebaseUser) {
      Navigator.pushReplacementNamed(context, "/");
    });

  }

  _loginUser(UserData user) {

    FirebaseAuth auth = FirebaseAuth.instance;

    auth.signInWithEmailAndPassword(
        email: user.email,
        password: user.password
    ).then((firebaseUser) {
      Navigator.pushReplacementNamed(context, "/");
    });

  }

  _validateFields() {

    String email = _controllerEmail.text;
    String password = _controllerPassword.text;

    if (email.isNotEmpty && email.contains("@")) {
      if (password.isNotEmpty && password.length > 6) {

        UserData user = UserData();
        user.email = email;
        user.password = password;

        if (_register) {
          _registerUser(user);
        } else {
          _loginUser(user);
        }
      } else {
        setState(() {
          _errorMsg = "Preencha a senha! digite mais de 6 caracteres";
        });
      }
    } else {
      setState(() {
        _errorMsg = "Preencha o E-mail válido";
      });
    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: Image.asset(
                    "images/logo.png",
                    width: 200,
                    height: 150,
                  ),
                ),
                StandardInput(
                  controller: _controllerEmail,
                  hint: "E-mail",
                  autofocus: true,
                  type: TextInputType.emailAddress,
                ),
                StandardInput(
                    controller: _controllerPassword,
                    hint: "Senha",
                    obscure: true
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Logar"),
                    Switch(
                      value: _register,
                      onChanged: (bool valor) {
                        setState(() {
                          _register = valor;
                          _buttonText = "Entrar";
                          if (_register) {
                            _buttonText = "Cadastrar";
                          }
                        });
                      },
                    ),
                    Text("Cadastrar"),
                  ],
                ),
                StandardButton(
                  text: _buttonText,
                  onPressed: () {
                    _validateFields();
                  },
                ),
                FlatButton(
                  child: Text("Ir para anúncios"),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/");
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    _errorMsg,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );

  }

}