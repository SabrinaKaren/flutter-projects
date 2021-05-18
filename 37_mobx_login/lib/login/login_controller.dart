/*
  Sabrina Karen
*/

import 'package:mobx/mobx.dart';
part 'login_controller.g.dart';

class LoginController = LoginControllerBase with _$LoginController;

abstract class LoginControllerBase with Store {

  LoginControllerBase() {
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