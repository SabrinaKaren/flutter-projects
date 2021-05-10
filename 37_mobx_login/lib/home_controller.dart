/*
  Sabrina Karen
*/

import 'package:mobx/mobx.dart';
part 'home_controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store {

  HomeControllerBase() {
    autorun((_) {
      print(email);
      print(password);
    });
  }

  @observable
  String email = '';

  @observable
  String password = '';

  @computed
  String get emailAndPassword => "$email - $password";

  @computed
  bool get formIsValid => email.length >= 5 && password.length >= 3;

  @action
  void setEmail(value) => email = value;

  @action
  void setPassword(value) => password = value;
  
}