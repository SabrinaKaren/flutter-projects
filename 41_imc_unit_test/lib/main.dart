import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:imc_unit_test/person_bloc.dart';
import 'package:imc_unit_test/person_repository.dart';
import 'bloc_provider.dart';
import 'home_page.dart';

void main() {
  runApp(MaterialApp(
    home: BlocProvider(
      bloc: PersonBloc(PersonRepository(Client())),
      child: HomePage(),
    ),
    debugShowCheckedModeBanner: false,
  ));
}