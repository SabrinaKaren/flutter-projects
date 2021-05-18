/*
  Sabrina Karen
*/

import 'package:mobx/mobx.dart';
part 'home_controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store {

  HomeControllerBase() {
    autorun((_) {
      /*print(email);
      print(password);*/
    });
  }

  @observable
  String email = '';

  @observable
  String password = '';

  @computed
  String get emailAndPassword => "$email - $password";

  @computed
  bool get formIsValid => email.length >= 4 && password.length >= 4;

  @observable
  bool userIsLogged = false;

  @observable
  bool loading = false;

  @action
  void setEmail(value) => email = value;

  @action
  void setPassword(value) => password = value;

  @action
  Future<void> doLogin() async {

    loading = true;
    await Future.delayed(Duration(seconds: 3));
    loading = false;
    userIsLogged = true;

  }
  
}