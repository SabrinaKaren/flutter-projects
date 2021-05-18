/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_login/home/home_view.dart';
import 'login_controller.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  LoginController _loginController = LoginController();
  ReactionDisposer _reactionDisposer;

  @override
  void didChangeDependencies() {

    super.didChangeDependencies();

    /*autorun((_) {
      print(_loginController.formIsValid);
    });*/

    _reactionDisposer = reaction(
      (_) => _loginController.userIsLogged,
      (value) {
        if (value) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => HomeView())
          );
        }
      }
    );

  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      child: Scaffold(
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 30),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'E-mail',
                        contentPadding: EdgeInsets.fromLTRB(20, 20, 10, 10),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        isDense: true,
                      ),
                      onChanged: _loginController.setEmail,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 35),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        contentPadding: EdgeInsets.fromLTRB(20, 20, 10, 10),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        isDense: true,
                      ),
                      onChanged: _loginController.setPassword,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 40),
                    child: Observer(
                      builder: (_) {
                        return Text(
                          _loginController.formIsValid ? "Validado" : "* Campos não validados: ",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        );
                      },
                    ),
                  ),
                  Observer(
                    builder: (_) {
                      return ElevatedButton(
                        child: _loginController.loading
                            ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white))
                            : Text('Logar'),
                        onPressed: _loginController.formIsValid ? () {_loginController.doLogin();} : null,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
    );

  }

  @override
  void dispose() {
    _reactionDisposer();
    super.dispose();
  }

}