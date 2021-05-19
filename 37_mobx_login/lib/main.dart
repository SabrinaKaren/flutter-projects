/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:mobx_login/login/login_controller.dart';
import 'package:provider/provider.dart';
import 'login/login_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<LoginController>(
          create: (_) => LoginController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginView(),
      ),
    ),
  );
}