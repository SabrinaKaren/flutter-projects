/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  FirebaseAuth auth = FirebaseAuth.instance;

  String email = "sabrinaa.karen@hotmail.com";
  String password = "123456";

  // criando usuário
  /*auth.createUserWithEmailAndPassword(
      email: email,
      password: password
  ).then((firebaseUser){
    print("Novo usuario: sucesso!! e-mail: " + firebaseUser.user.email);
  }).catchError((error){
    print("Novo usuario: erro!! " + error.toString());
  });*/

  // deslogando usuário
  /*auth.signOut();*/

  // logando usuário
  auth.signInWithEmailAndPassword(
      email: email,
      password: password
  ).then((firebaseUser){
    print("Logar usuario: sucesso!! e-mail: " + firebaseUser.user.email);
  }).catchError((erro){
    print("Logar usuario: erro!! " + erro.toString());
  });

  // verificando se o usário está logado
  FirebaseUser currentUser = await auth.currentUser();
  if(currentUser != null){
    print("Usuario atual logado email: " + currentUser.email);
  }else{
    print("Usuario atual está DESLOGADO!!");
  }

  runApp( App() );

}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}