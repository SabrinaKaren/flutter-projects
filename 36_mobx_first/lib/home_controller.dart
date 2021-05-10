/*
  Sabrina Karen
*/

import 'package:mobx/mobx.dart';
part 'home_controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store {

  @observable
  int counter = 0;

  @action
  doIncrement() {
    counter++;
  }
  
  /*var _counter = Observable(0);
  Action increment;

  HomeController() {
    increment = Action(_doIncrement);
  }

  int get counter => _counter.value;
  set counter(int newValue) => _counter.value = newValue;

  _doIncrement() {
    counter++;
  }*/
  
}