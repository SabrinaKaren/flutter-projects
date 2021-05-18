/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'home_controller.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  HomeController _homeController = HomeController();
  ReactionDisposer _reactionDisposer;

  @override
  void didChangeDependencies() {

    super.didChangeDependencies();

    /*autorun((_) {
      print(_homeController.formIsValid);
    });*/

    _reactionDisposer = reaction(
      (_) => _homeController.userIsLogged,
      (value) {
        print(value);
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
                      onChanged: _homeController.setEmail,
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
                      onChanged: _homeController.setPassword,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 40),
                    child: Observer(
                      builder: (_) {
                        return Text(
                          _homeController.formIsValid ? "Validado" : "* Campos não validados: ",
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
                        child: _homeController.loading
                            ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white))
                            : Text('Logar'),
                        onPressed: _homeController.formIsValid ? () {_homeController.doLogin();} : null,
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