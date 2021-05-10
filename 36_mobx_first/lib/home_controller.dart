/*
  Sabrina Karen
*/

import 'package:mobx/mobx.dart';

class HomeController {
  
  var _counter = Observable(0);
  Action increment;

  HomeController() {
    increment = Action(_doIncrement);
  }

  int get counter => _counter.value;
  set counter(int newValue) => _counter.value = newValue;

  _doIncrement() {
    counter++;
  }
  
}