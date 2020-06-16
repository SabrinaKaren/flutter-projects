/*
  Sabrina Karen
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uber/Data/UserData.dart';
import 'package:uber/Pages/RegisterPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  String _errorMsg = "";
  bool _loading = false;

  _validateFields(){

    String email = _controllerEmail.text;
    String password = _controllerPassword.text;

    if(email.isNotEmpty && email.contains("@")){

      if(password.isNotEmpty && password.length > 6){

        UserData user = UserData();
        user.email = email;
        user.password = password;

        _loginUser(user);

      }else{
        setState(() {
          _errorMsg = "Preencha a senha! digite mais de 6 caracteres";
        });
      }

    }else{
      setState(() {
        _errorMsg = "Preencha o E-mail válido";
      });
    }

  }

  _loginUser(UserData user){

    setState(() {
      _loading = true;
    });

    FirebaseAuth auth = FirebaseAuth.instance;

    auth.signInWithEmailAndPassword(
        email: user.email,
        password: user.password
    ).then((firebaseUser){

      _redirectsByUserType(firebaseUser.user.uid);

    }).catchError((error){
      _errorMsg = "Erro ao autenticar usuário, verifique e-mail e senha e tente novamente!";
    });

  }

  _redirectsByUserType(String userId) async {

    Firestore db = Firestore.instance;

    DocumentSnapshot snapshot = await db.collection("usuarios")
        .document(userId)
        .get();

    Map<String, dynamic> data = snapshot.data;
    String userType = data["tipoUsuario"];

    setState(() {
      _loading = false;
    });

    switch(userType){
      case "motorista" :
        Navigator.pushReplacementNamed(context, "/motorista");
        break;
      case "passageiro" :
        Navigator.pushReplacementNamed(context, "/passageiro");
        break;
    }

  }

  _checkLoggedUser() async {

    FirebaseAuth auth = FirebaseAuth.instance;

    FirebaseUser loggedUser = await auth.currentUser();
    if(loggedUser != null){
      String userId = loggedUser.uid;
      _redirectsByUserType(userId);
    }

  }

  @override
  void initState() {
    super.initState();
    _checkLoggedUser();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/fundo.png"),
                fit: BoxFit.cover
            )
        ),
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
                TextField(
                  controller: _controllerEmail,
                  autofocus: true,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "e-mail",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6)
                      )
                  ),
                ),
                TextField(
                  controller: _controllerPassword,
                  obscureText: true,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "senha",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6)
                      )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 10),
                  child: RaisedButton(
                      child: Text(
                        "Entrar",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      color: Color(0xff1ebbd8),
                      padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      onPressed: (){
                        _validateFields();
                      }
                  ),
                ),
                Center(
                  child: GestureDetector(
                    child: Text(
                      "Não tem conta? cadastre-se!",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: (){
                      Navigator.pushNamed(context, "/cadastro");
                    },
                  ),
                ),
                _loading
                    ? Center(child: CircularProgressIndicator(backgroundColor: Colors.white,),)
                    : Container(),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Center(
                    child: Text(
                      "Erro",
                      style: TextStyle(color: Colors.red, fontSize: 20),
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